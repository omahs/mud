package ingress

import (
	"encoding/json"
	"latticexyz/mud/packages/services/pkg/mode"
	"latticexyz/mud/packages/services/pkg/mode/schema"
	"latticexyz/mud/packages/services/pkg/mode/storecore"
	"latticexyz/mud/packages/services/pkg/mode/write"
	pb_mode "latticexyz/mud/packages/services/protobuf/go/mode"
	"strings"

	"github.com/ethereum/go-ethereum/common/hexutil"
	"github.com/umbracle/ethgo/abi"
	"go.uber.org/zap"
)

func (il *IngressLayer) handleSetRecordEvent(event *storecore.StorecoreStoreSetRecord) {
	tableId := storecore.PaddedTableId(event.Table)
	il.logger.Info("handling set record event", zap.String("table_id", tableId))

	// Handle the following scenarios:
	// 1. The table is the schema table. This means that a new table should be created.
	// 2. The table is the metadata table. This means we need to update a schema of an existing table.
	// 3. The table is a generic table. This means we need to update rows of an existing table.
	println("-------------------------------------------------------")
	println("-------------------------------------------------------")
	println("------------------StoreSetRecordEvent------------------")
	println("-------------------------------------------------------")
	println("-------------------------------------------------------")

	switch tableId {
	case storecore.Internal__SchemaTableId():
		println("----------------handleSchemaTableEvent-----------------")
		println("-------------------------------------------------------")
		println("-------------------------------------------------------")
		il.handleSchemaTableEvent(event)
	case storecore.Internal__MetadataTableId():
		println("---------------handleMetadataTableEvent----------------")
		println("-------------------------------------------------------")
		println("-------------------------------------------------------")
		il.handleMetadataTableEvent(event)
	default:
		println("---------------handleGenericTableEvent-----------------")
		println("-------------------------------------------------------")
		println("-------------------------------------------------------")
		il.handleGenericTableEvent(event)
	}
}

func (il *IngressLayer) handleSetFieldEventUpdateRow(event *storecore.StorecoreStoreSetField, tableSchema *mode.TableSchema, filter []*pb_mode.Filter) {
	// Decode the field.
	fieldValue := storecore.DecodeDataField(event.Data, *tableSchema.StoreCoreSchemaTypeKV.Value, event.SchemaIndex)

	// Get the name of the field. This is the name of the column in the database and the way to
	// get it is just to lookup what the field name is at the specified index in the schema, since
	// schema types and field names are 1:1.
	fieldName := tableSchema.FieldNames[event.SchemaIndex]

	// Create a row object. It's a partial row because we're only updating a single field.
	partialRow := write.RowKV{
		fieldName: fieldValue,
	}
	// Update the row.
	il.wl.UpdateRow(tableSchema, partialRow, filter)
}

func (il *IngressLayer) handleSetFieldEventInsertRow(event *storecore.StorecoreStoreSetField, tableSchema *mode.TableSchema, filter []*pb_mode.Filter) {
	// Decode the row record data (value).
	decodedData := storecore.DecodeData(event.Data, *tableSchema.StoreCoreSchemaTypeKV.Value)

	// Create a row for the table.
	row := write.RowKV{}
	for idx, field_name := range tableSchema.FieldNames {
		row[field_name] = decodedData.DataAt(idx)
	}

	println("inserting new row for setField")

	// Insert the row into the table.
	il.wl.InsertRow(tableSchema, row)
}

func (il *IngressLayer) handleSetFieldEvent(event *storecore.StorecoreStoreSetField) {
	println("-------------------------------------------------------")
	println("-------------------------------------------------------")
	println("------------------StoreSetFieldEvent------------------")
	println("-------------------------------------------------------")
	println("-------------------------------------------------------")

	tableId := storecore.PaddedTableId(event.Table)
	il.logger.Info("handling set field event", zap.String("table_id", tableId))

	// Fetch the schema for the target table.
	tableSchema, err := il.schemaCache.GetTableSchema(il.chainConfig.Id, event.WorldAddress(), schema.TableIdToTableName(tableId))
	if err != nil {
		il.logger.Error("failed to get table schema", zap.Error(err))
		return
	}

	// Handle the following scenarios:
	// 1. The setField event is modifying a row that doesn't yet exist (i.e. key doesn't match anything),
	//    in which case we insert a new row with default values for each column.
	//
	// 2. The setField event is modifying a row that already exists, in which case we update the
	//    row by constructing a partial row with the new value for the field that was modified.

	// Build the "filter" from the setField key. This is used to find the actual row/record that
	// we're updating (or inserting if doesn't exist).
	// TODO: properly parse out the key and build a "filter" that the builder can use.
	filter := KeyToFilter(tableSchema, event.Key)

	rowExists, err := il.rl.DoesRowExist(tableSchema, filter)
	if err != nil {
		il.logger.Error("failed to check if row exists", zap.Error(err))
		return
	}

	// Handle the two scenarios described above.
	if rowExists {
		println("ROW EXISTS")
		il.handleSetFieldEventUpdateRow(event, tableSchema, filter)
	} else {
		println("ROW DOES NOT EXIST")
		il.handleSetFieldEventInsertRow(event, tableSchema, filter)
	}
}

func (il *IngressLayer) handleDeleteRecordEvent(event *storecore.StorecoreStoreDeleteRecord) {
	tableId := storecore.PaddedTableId(event.Table)
	il.logger.Info("handling delete record event", zap.String("table_id", tableId))

	// Fetch the schema for the target table.
	tableSchema, err := il.schemaCache.GetTableSchema(il.chainConfig.Id, event.WorldAddress(), schema.TableIdToTableName(tableId))
	if err != nil {
		il.logger.Error("failed to get table schema", zap.Error(err))
		return
	}

	// TODO: properly parse out the key and build a "filter" that the delete request builder can use.
	filter := KeyToFilter(tableSchema, event.Key)
	il.wl.DeleteRow(tableSchema, filter)

	il.logger.Info("delete record event handled", zap.String("table_id", tableId))
}

func (il *IngressLayer) handleSchemaTableEvent(event *storecore.StorecoreStoreSetRecord) {
	tableId := hexutil.Encode(event.Key[0][:])
	il.logger.Info("handling schema table event", zap.String("world_address", event.WorldAddress()), zap.String("table_id", tableId))

	// Parse out the schema types (both static and dynamic) for the table.
	valueStoreCoreSchemaTypePair := storecore.DecodeSchemaTypePair(event.Data[:32])
	// The last 32 bytes are the table "key" schema.
	keyStoreCoreSchemaTypePair := storecore.DecodeSchemaTypePair(event.Data[32:])

	// Merge the two schemas into one, since the table schema is a combination of the key schema and the value schema.
	storeCoreSchemaTypeKV := storecore.SchemaTypeKVFromPairs(keyStoreCoreSchemaTypePair, valueStoreCoreSchemaTypePair)

	println("length of data: ", len(event.Data))
	println("merged schema: ", storecore.StringifySchemaTypes(storeCoreSchemaTypeKV.Flatten()))

	// Create a schema table row for the table.
	tableSchema := &mode.TableSchema{
		TableId:               tableId,
		TableName:             schema.TableIdToTableName(tableId),
		StoreCoreSchemaTypeKV: storeCoreSchemaTypeKV,
		// Create a postgres namespace ('schema') for the world address + the chain (if it doesn't already exist).
		Namespace: schema.Namespace(il.chainConfig.Id, event.WorldAddress()),
		// Keeping track of capitalized field names for compatibility with clients.
		CapitalizationMap: map[string]string{},
	}

	// Populate the schema with default values. First populate values.
	for idx, schemaType := range storeCoreSchemaTypeKV.Value.Flatten() {
		columnName := schema.DefaultFieldName(idx)
		tableSchema.FieldNames = append(tableSchema.FieldNames, columnName)

		solidityType := storecore.SchemaTypeToSolidityType(schemaType)
		postgresType := storecore.SchemaTypeToPostgresType(schemaType)

		if tableSchema.SolidityTypes == nil {
			tableSchema.SolidityTypes = make(map[string]string)
		}
		tableSchema.SolidityTypes[columnName] = solidityType

		if tableSchema.PostgresTypes == nil {
			tableSchema.PostgresTypes = make(map[string]string)
		}
		tableSchema.PostgresTypes[columnName] = postgresType
	}
	// Then populate keys.
	for idx, schemaType := range storeCoreSchemaTypeKV.Key.Flatten() {
		columnName := schema.DefaultKeyName(idx)
		tableSchema.KeyNames = append(tableSchema.KeyNames, columnName)

		solidityType := storecore.SchemaTypeToSolidityType(schemaType)
		postgresType := storecore.SchemaTypeToPostgresType(schemaType)

		if tableSchema.SolidityTypes == nil {
			tableSchema.SolidityTypes = make(map[string]string)
		}
		tableSchema.SolidityTypes[columnName] = solidityType

		if tableSchema.PostgresTypes == nil {
			tableSchema.PostgresTypes = make(map[string]string)
		}
		tableSchema.PostgresTypes[columnName] = postgresType
	}

	// Create the table with the schema so far (this can be updated with metadata later).
	il.wl.CreateTable(tableSchema)
	tableSchemaJson, _ := json.Marshal(tableSchema)

	// Save the row with whatever information is known so far into the schema table.
	schemaTableSchema := schema.Internal__SchemaTableSchema(il.chainConfig.Id)
	row := write.RowKV{
		"world_address": event.WorldAddress(),
		"namespace":     tableSchema.Namespace,
		"table_name":    tableSchema.TableName,
		"schema":        string(tableSchemaJson),
	}
	// Filter based on table name, world address, and namespace.
	filter := schemaTableSchema.FilterFromMap(map[string]string{
		"table_name":    tableSchema.TableName,
		"world_address": event.WorldAddress(),
		"namespace":     tableSchema.Namespace,
	})
	il.wl.UpdateOrInsertRow(schemaTableSchema, row, filter)

	il.logger.Info("schema table event handled", zap.String("world_address", event.WorldAddress()), zap.String("table_name", hexutil.Encode(event.Key[0][:])), zap.String("schema", string(tableSchemaJson)))
}

func (il *IngressLayer) handleMetadataTableEvent(event *storecore.StorecoreStoreSetRecord) {
	tableId := hexutil.Encode(event.Key[0][:])
	il.logger.Info("handling metadata table event", zap.String("world_address", event.WorldAddress()), zap.String("table_id", tableId))

	// Fetch the schema for the target table (table to which the metadata is being added).
	tableSchema, err := il.schemaCache.GetTableSchema(il.chainConfig.Id, event.Raw.Address.Hex(), schema.TableIdToTableName(tableId))
	if err != nil {
		il.logger.Error("failed to fetch schema for target table", zap.Error(err))
		return
	}

	// Fetch the schema for the metadata table.
	metadataTableSchema, err := il.schemaCache.GetTableSchema(il.chainConfig.Id, event.WorldAddress(), schema.TableIdToTableName(storecore.Internal__MetadataTableId()))
	if err != nil {
		il.logger.Error("failed to fetch schema for metadata table", zap.Error(err))
		return
	}

	// Decode the metadata.
	decodedMetadata := storecore.DecodeData(event.Data, *metadataTableSchema.StoreCoreSchemaTypeKV.Value)

	// Since we know the structure of the metadata, we decode it directly into types and handle.
	tableReadableName := decodedMetadata.DataAt(0)
	tableColumnNames := decodedMetadata.DataAt(1)

	// Extract the column names from the metadata.
	tableColumnNamesBytes, _ := hexutil.Decode(tableColumnNames)
	// For some reason just string[] doesn't work with abi decoding here, so we use a tuple.
	_type := abi.MustNewType("tuple(string[] cols)")
	outStruct := struct {
		Cols []string
	}{
		Cols: []string{},
	}
	err = _type.DecodeStruct(tableColumnNamesBytes, &outStruct)
	if err != nil {
		il.logger.Error("failed to decode table column names", zap.Error(err))
		return
	}

	// Add extracted metdata to the schema, essentially completing it.
	//
	// 1. Add the readable name.
	// 2. Add the column names and types.
	tableSchema.ReadableName = tableReadableName

	// Keep a record of the old field names so we can update the table.
	oldTableFieldNames := tableSchema.FieldNames
	// Keep a record of the new field names so we can update the table.
	newTableFieldNames := []string{}

	for idx, schemaType := range tableSchema.StoreCoreSchemaTypeKV.Value.Flatten() {
		capitalizedColumnName := outStruct.Cols[idx]
		columnName := strings.ToLower(capitalizedColumnName)
		newTableFieldNames = append(newTableFieldNames, columnName)

		solidityType := storecore.SchemaTypeToSolidityType(schemaType)
		postgresType := storecore.SchemaTypeToPostgresType(schemaType)

		// Update the solidity types to match the new field names (column names).
		if tableSchema.SolidityTypes == nil {
			tableSchema.SolidityTypes = make(map[string]string)
		}
		tableSchema.SolidityTypes[columnName] = solidityType

		// Update the postgres types to match the new field names (column names).
		if tableSchema.PostgresTypes == nil {
			tableSchema.PostgresTypes = make(map[string]string)
		}
		tableSchema.PostgresTypes[columnName] = postgresType

		// Update capitalization map.
		if tableSchema.CapitalizationMap == nil {
			tableSchema.CapitalizationMap = make(map[string]string)
		}
		tableSchema.CapitalizationMap[columnName] = capitalizedColumnName
	}
	// Update the field names in the schema.
	tableSchema.FieldNames = newTableFieldNames

	// Save the completed schema to the schema table.
	tableSchemaJson, _ := json.Marshal(tableSchema)
	schemaTableSchema := schema.Internal__SchemaTableSchema(il.chainConfig.Id)
	row := write.RowKV{
		"world_address": event.WorldAddress(),
		"namespace":     tableSchema.Namespace,
		"table_name":    tableSchema.TableName,
		"schema":        string(tableSchemaJson),
	}
	filter := schemaTableSchema.FilterFromMap(map[string]string{
		"table_name":    tableSchema.TableName,
		"world_address": event.WorldAddress(),
		"namespace":     tableSchema.Namespace,
	})
	il.wl.UpdateOrInsertRow(schemaTableSchema, row, filter)

	// Update the table field names based on the new metadata.
	il.wl.RenameTableFields(tableSchema, oldTableFieldNames, tableSchema.FieldNames)
	// Update the table name.
	// il.wl.RenameTable(tableSchema, tableSchema.TableName, tableSchema.ReadableName)

	il.logger.Info("metadata table event handled (schema updated)", zap.String("world_address", event.WorldAddress()), zap.String("table_id", tableId), zap.String("schema", string(tableSchemaJson)))
}

func (il *IngressLayer) handleGenericTableEvent(event *storecore.StorecoreStoreSetRecord) {
	tableId := storecore.PaddedTableId(event.Table)
	il.logger.Info("handling generic table event", zap.String("world_address", event.WorldAddress()), zap.String("table_id", tableId))

	// Fetch the schema for the target table.
	tableSchema, err := il.schemaCache.GetTableSchema(il.chainConfig.Id, event.WorldAddress(), schema.TableIdToTableName(tableId))
	if err != nil {
		il.logger.Error("failed to get table schema", zap.Error(err))
		return
	}

	// Decode the row record data (value).
	decodedData := storecore.DecodeData(event.Data, *tableSchema.StoreCoreSchemaTypeKV.Value)

	// Create a row for the table.
	row := write.RowKV{}
	for idx, field_name := range tableSchema.FieldNames {
		row[field_name] = decodedData.DataAt(idx)
	}

	// Insert the row into the table.
	il.wl.InsertRow(tableSchema, row)

	il.logger.Info("generic table event handled", zap.String("world_address", event.WorldAddress()), zap.String("table_id", tableId), zap.Any("row", row))
}
