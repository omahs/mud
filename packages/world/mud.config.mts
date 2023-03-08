import { StoreUserConfig } from "@latticexyz/cli";
import { SchemaType } from "@latticexyz/schema-type";

const config: StoreUserConfig = {
  baseRoute: "/world_internals",

  tables: {
    NamespaceOwner: {
      primaryKeys: {
        namespace: SchemaType.BYTES16,
      },
      schema: {
        owner: SchemaType.ADDRESS,
      },
      storeArgument: true,
    },
    ResourceAccess: {
      primaryKeys: {
        selector: SchemaType.BYTES32,
        caller: SchemaType.ADDRESS,
      },
      schema: {
        access: SchemaType.BOOL,
      },
      storeArgument: true,
    },
    SystemRegistry: {
      primaryKeys: {
        system: SchemaType.ADDRESS,
      },
      schema: {
        resourceSelector: SchemaType.BYTES32,
      },
    },
    Systems: {
      primaryKeys: {
        resourceSelector: SchemaType.BYTES32,
      },
      schema: {
        system: SchemaType.ADDRESS,
        publicAccess: SchemaType.BOOL,
      },
      storeArgument: true,
      dataStruct: false,
    },
    // Bool: {
    //   primaryKeys: {},
    //   schema: {
    //     value: SchemaType.BOOL,
    //   },
    //   storeArgument: true, // TODO Add support for store argument in setter function to table autogen
    //   tableIdArgument: true,
    // },
  },
};

export default config;
