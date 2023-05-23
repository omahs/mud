// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/* Autogenerated file. Do not edit manually. */

import { Schema } from "@latticexyz/store/src/Schema.sol";
import { IStoreHook } from "@latticexyz/store/src/IStore.sol";
import { ISystemHook } from "./ISystemHook.sol";
import { System } from "./../System.sol";

interface IWorldRegistrationSystem {
  function registerNamespace(bytes16 namespace) external;

  function registerTable(
    bytes16 namespace,
    bytes16 name,
    Schema valueSchema,
    Schema keySchema
  ) external returns (bytes32 resourceSelector);

  function setMetadata(
    bytes16 namespace,
    bytes16 name,
    string calldata tableName,
    string[] calldata keyNames,
    string[] calldata fieldNames
  ) external;

  function registerHook(bytes16 namespace, bytes16 name, address hook) external;

  function registerTableHook(bytes16 namespace, bytes16 name, IStoreHook hook) external;

  function registerSystemHook(bytes16 namespace, bytes16 name, ISystemHook hook) external;

  function registerSystem(
    bytes16 namespace,
    bytes16 name,
    System system,
    bool publicAccess
  ) external returns (bytes32 resourceSelector);

  function registerFunctionSelector(
    bytes16 namespace,
    bytes16 name,
    string memory systemFunctionName,
    string memory systemFunctionArguments
  ) external returns (bytes4 worldFunctionSelector);

  function registerRootFunctionSelector(
    bytes16 namespace,
    bytes16 name,
    bytes4 worldFunctionSelector,
    bytes4 systemFunctionSelector
  ) external returns (bytes4);
}
