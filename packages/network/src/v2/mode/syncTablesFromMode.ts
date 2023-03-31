import { ComponentValue } from "@latticexyz/recs";
import { AbiTypeToSchemaType, encodeSchema } from "@latticexyz/schema-type";
import { QueryLayerClient } from "@latticexyz/services/protobuf/ts/mode/mode";
import { arrayToHex, TableId } from "@latticexyz/utils";
import { Contract } from "ethers";
import { NetworkEvents } from "../../types";

import { CacheStore, createCacheStore, storeEvent } from "../../workers";
import { keyTupleToEntityID } from "../keyTupleToEntityID";
import { decodeValue } from "../schemas/decodeValue";
import { registerMetadata } from "../schemas/tableMetadata";
import { registerSchema } from "../schemas/tableSchemas";
import { getBlockNumberFromModeTable } from "./getBlockNumberFromModeTable";

export async function syncTablesFromMode(
  client: QueryLayerClient,
  chainId: number,
  world: Contract,
  setPercentage?: (progress: number) => void
): Promise<CacheStore> {
  const cacheStore = createCacheStore();

  const response = await client.getState({
    chainTables: [],
    worldTables: [],
    namespace: {
      chainId: chainId.toString(),
      worldAddress: world.address,
    },
  });
  console.log("syncTablesFromMode", response);

  const numRowsTotal = Object.values(response.worldTables).reduce((sum, table) => sum + table.rows.length, 0);
  let numRowsProcessed = 0;

  const blockNumber = getBlockNumberFromModeTable(response.chainTables["block_number"]);
  const registrationPromises: Promise<unknown>[] = [];

  for (const [fullTableName, { rows, cols, types }] of Object.entries(response.worldTables)) {
    const [tableNamespace, tableName] = fullTableName.split("__");
    const tableId = new TableId(tableNamespace, tableName);

    const component = tableId.toString();

    // TODO: separate keys and values/fields in MODE, but we'll infer for now
    const keyLength = cols.findIndex((col) => !col.startsWith("key_"));
    const keyNames = cols.slice(0, keyLength); // TODO: key names are not currently included in the MetadataTable, so these are unused
    const keyTypes = types.slice(0, keyLength).map((abiType) => AbiTypeToSchemaType[abiType]);
    const fieldNames = cols.slice(keyLength);
    const fieldTypes = types
      .slice(keyLength)
      .map((modeType) => modeType.match(/tuple\((.*)\[]\)/)?.[1] ?? modeType) // TODO: remove this hack once MODE is fixed
      .map((abiType) => AbiTypeToSchemaType[abiType]);

    console.log(fullTableName, types, keyLength, fieldTypes);
    const rawSchema = arrayToHex(encodeSchema(fieldTypes));
    // TODO: refactor registerSchema/registerMetadata to take chain+world address rather than Contract
    registrationPromises.push(registerSchema(world, tableId, rawSchema));
    registrationPromises.push(registerMetadata(world, tableId, { tableName, fieldNames }));

    for (const row of rows) {
      const keyTuple = row.values.slice(0, keyLength).map((bytes, i) => decodeValue(keyTypes[i], bytes));
      const values = row.values.slice(keyLength).map((bytes, i) => decodeValue(fieldTypes[i], bytes));

      const entity = keyTupleToEntityID(keyTuple);
      const value = Object.fromEntries(values.map((value, i) => [fieldNames[i], value])) as ComponentValue;

      storeEvent(cacheStore, { type: NetworkEvents.NetworkComponentUpdate, component, entity, value, blockNumber });

      numRowsProcessed++;
      // Update progress every 100 rows
      if (numRowsProcessed % 100 === 0 && setPercentage) {
        setPercentage(Math.floor(numRowsProcessed / numRowsTotal));
      }
    }
  }

  // make sure all schemas/metadata are registered before returning to avoid downstream lookup issues
  await Promise.all(registrationPromises);

  return cacheStore;
}
