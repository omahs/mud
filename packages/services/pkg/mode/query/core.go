package query

import (
	"latticexyz/mud/packages/services/pkg/grpc"
	"latticexyz/mud/packages/services/pkg/mode"
	"latticexyz/mud/packages/services/pkg/mode/db"
	"latticexyz/mud/packages/services/pkg/mode/schema"

	pb_mode "latticexyz/mud/packages/services/protobuf/go/mode"

	"go.uber.org/zap"
)

func NewQueryLayer(
	dl *db.DatabaseLayer,
	schemaCache *schema.SchemaCache,
	tableSchemas map[string]*mode.TableSchema,
	logger *zap.Logger,
) *QueryLayer {
	return &QueryLayer{
		dl:           dl,
		schemaCache:  schemaCache,
		tableSchemas: tableSchemas,
		logger:       logger,
	}
}

func RunQueryLayer(ql *QueryLayer, qlGrpcPort int) {
	// Create gRPC server.
	grpcServer := grpc.CreateGrpcServer()

	// Create and register the QueryLayer service.
	pb_mode.RegisterQueryLayerServer(grpcServer, ql)

	// Start the RPC server at PORT.
	go grpc.StartRPCServer(grpcServer, qlGrpcPort, ql.logger)

	// Start the HTTP server at PORT+1.
	grpc.StartHTTPServer(grpc.CreateWebGrpcServer(grpcServer), qlGrpcPort+1, ql.logger)
}
