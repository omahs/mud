/* Autogenerated file. Do not edit manually. */

import { TableId } from "@latticexyz/utils";
import { defineComponent, Type as RecsType, World } from "@latticexyz/recs";

export function defineContractComponents(world: World) {
  return {
    Hooks: (() => {
      const tableId = new TableId("mudstore", "Hooks");
      return defineComponent(
        world,
        {
          value: RecsType.StringArray,
        },
        {
          metadata: {
            contractId: tableId.toHexString(),
            tableId: tableId.toString(),
          },
        }
      );
    })(),
    Callbacks: (() => {
      const tableId = new TableId("mudstore", "Callbacks");
      return defineComponent(
        world,
        {
          value: RecsType.StringArray,
        },
        {
          metadata: {
            contractId: tableId.toHexString(),
            tableId: tableId.toString(),
          },
        }
      );
    })(),
    StoreMetadata: (() => {
      const tableId = new TableId("mudstore", "StoreMetadata");
      return defineComponent(
        world,
        {
          tableName: RecsType.String,
          abiEncodedFieldNames: RecsType.String,
        },
        {
          metadata: {
            contractId: tableId.toHexString(),
            tableId: tableId.toString(),
          },
        }
      );
    })(),
    Mixed: (() => {
      const tableId = new TableId("mudstore", "Mixed");
      return defineComponent(
        world,
        {
          u32: RecsType.Number,
          u128: RecsType.BigInt,
          a32: RecsType.NumberArray,
          s: RecsType.String,
        },
        {
          metadata: {
            contractId: tableId.toHexString(),
            tableId: tableId.toString(),
          },
        }
      );
    })(),
    Vector2: (() => {
      const tableId = new TableId("mudstore", "Vector2");
      return defineComponent(
        world,
        {
          x: RecsType.Number,
          y: RecsType.Number,
        },
        {
          metadata: {
            contractId: tableId.toHexString(),
            tableId: tableId.toString(),
          },
        }
      );
    })(),
    SignedKeys: (() => {
      const tableId = new TableId("mudstore", "SignedKeys");
      return defineComponent(
        world,
        {
          value: RecsType.Boolean,
        },
        {
          metadata: {
            contractId: tableId.toHexString(),
            tableId: tableId.toString(),
          },
        }
      );
    })(),
  };
}
