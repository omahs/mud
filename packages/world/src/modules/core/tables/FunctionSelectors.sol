// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/* Autogenerated file. Do not edit manually. */

// Import schema type
import { SchemaType } from "@latticexyz/schema-type/src/solidity/SchemaType.sol";

// Import store internals
import { IStore } from "@latticexyz/store/src/IStore.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";
import { StoreCore } from "@latticexyz/store/src/StoreCore.sol";
import { Bytes } from "@latticexyz/store/src/Bytes.sol";
import { Memory } from "@latticexyz/store/src/Memory.sol";
import { SliceLib } from "@latticexyz/store/src/Slice.sol";
import { EncodeArray } from "@latticexyz/store/src/tightcoder/EncodeArray.sol";
import { Schema, SchemaLib } from "@latticexyz/store/src/Schema.sol";
import { PackedCounter, PackedCounterLib } from "@latticexyz/store/src/PackedCounter.sol";

bytes32 constant _tableId = bytes32(abi.encodePacked(bytes16(""), bytes16("FunctionSelector")));
bytes32 constant FunctionSelectorsTableId = _tableId;

library FunctionSelectors {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](3);
    _schema[0] = SchemaType.BYTES16;
    _schema[1] = SchemaType.BYTES16;
    _schema[2] = SchemaType.BYTES4;

    return SchemaLib.encode(_schema);
  }

  function getKeySchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](1);
    _schema[0] = SchemaType.BYTES4;

    return SchemaLib.encode(_schema);
  }

  /** Get the table's metadata */
  function getMetadata() internal pure returns (string memory, string[] memory) {
    string[] memory _fieldNames = new string[](3);
    _fieldNames[0] = "namespace";
    _fieldNames[1] = "name";
    _fieldNames[2] = "systemFunctionSelector";
    return ("FunctionSelectors", _fieldNames);
  }

  /** Register the table's schema */
  function registerSchema() internal {
    StoreSwitch.registerSchema(_tableId, getSchema(), getKeySchema());
  }

  /** Register the table's schema (using the specified store) */
  function registerSchema(IStore _store) internal {
    _store.registerSchema(_tableId, getSchema(), getKeySchema());
  }

  /** Set the table's metadata */
  function setMetadata() internal {
    (string memory _tableName, string[] memory _fieldNames) = getMetadata();
    StoreSwitch.setMetadata(_tableId, _tableName, _fieldNames);
  }

  /** Set the table's metadata (using the specified store) */
  function setMetadata(IStore _store) internal {
    (string memory _tableName, string[] memory _fieldNames) = getMetadata();
    _store.setMetadata(_tableId, _tableName, _fieldNames);
  }

  /** Get namespace */
  function getNamespace(bytes4 functionSelector) internal view returns (bytes16 namespace) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(abi.encode(functionSelector));

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 0);
    return (Bytes.slice16(_blob, 0));
  }

  /** Get namespace (using the specified store) */
  function getNamespace(IStore _store, bytes4 functionSelector) internal view returns (bytes16 namespace) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(abi.encode(functionSelector));

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 0);
    return (Bytes.slice16(_blob, 0));
  }

  /** Set namespace */
  function setNamespace(bytes4 functionSelector, bytes16 namespace) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(abi.encode(functionSelector));

    StoreSwitch.setField(_tableId, _keyTuple, 0, abi.encodePacked((namespace)));
  }

  /** Set namespace (using the specified store) */
  function setNamespace(IStore _store, bytes4 functionSelector, bytes16 namespace) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(abi.encode(functionSelector));

    _store.setField(_tableId, _keyTuple, 0, abi.encodePacked((namespace)));
  }

  /** Get name */
  function getName(bytes4 functionSelector) internal view returns (bytes16 name) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(abi.encode(functionSelector));

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 1);
    return (Bytes.slice16(_blob, 0));
  }

  /** Get name (using the specified store) */
  function getName(IStore _store, bytes4 functionSelector) internal view returns (bytes16 name) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(abi.encode(functionSelector));

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 1);
    return (Bytes.slice16(_blob, 0));
  }

  /** Set name */
  function setName(bytes4 functionSelector, bytes16 name) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(abi.encode(functionSelector));

    StoreSwitch.setField(_tableId, _keyTuple, 1, abi.encodePacked((name)));
  }

  /** Set name (using the specified store) */
  function setName(IStore _store, bytes4 functionSelector, bytes16 name) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(abi.encode(functionSelector));

    _store.setField(_tableId, _keyTuple, 1, abi.encodePacked((name)));
  }

  /** Get systemFunctionSelector */
  function getSystemFunctionSelector(bytes4 functionSelector) internal view returns (bytes4 systemFunctionSelector) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(abi.encode(functionSelector));

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 2);
    return (Bytes.slice4(_blob, 0));
  }

  /** Get systemFunctionSelector (using the specified store) */
  function getSystemFunctionSelector(
    IStore _store,
    bytes4 functionSelector
  ) internal view returns (bytes4 systemFunctionSelector) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(abi.encode(functionSelector));

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 2);
    return (Bytes.slice4(_blob, 0));
  }

  /** Set systemFunctionSelector */
  function setSystemFunctionSelector(bytes4 functionSelector, bytes4 systemFunctionSelector) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(abi.encode(functionSelector));

    StoreSwitch.setField(_tableId, _keyTuple, 2, abi.encodePacked((systemFunctionSelector)));
  }

  /** Set systemFunctionSelector (using the specified store) */
  function setSystemFunctionSelector(IStore _store, bytes4 functionSelector, bytes4 systemFunctionSelector) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(abi.encode(functionSelector));

    _store.setField(_tableId, _keyTuple, 2, abi.encodePacked((systemFunctionSelector)));
  }

  /** Get the full data */
  function get(
    bytes4 functionSelector
  ) internal view returns (bytes16 namespace, bytes16 name, bytes4 systemFunctionSelector) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(abi.encode(functionSelector));

    bytes memory _blob = StoreSwitch.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Get the full data (using the specified store) */
  function get(
    IStore _store,
    bytes4 functionSelector
  ) internal view returns (bytes16 namespace, bytes16 name, bytes4 systemFunctionSelector) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(abi.encode(functionSelector));

    bytes memory _blob = _store.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Set the full data using individual values */
  function set(bytes4 functionSelector, bytes16 namespace, bytes16 name, bytes4 systemFunctionSelector) internal {
    bytes memory _data = encode(namespace, name, systemFunctionSelector);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(abi.encode(functionSelector));

    StoreSwitch.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using individual values (using the specified store) */
  function set(
    IStore _store,
    bytes4 functionSelector,
    bytes16 namespace,
    bytes16 name,
    bytes4 systemFunctionSelector
  ) internal {
    bytes memory _data = encode(namespace, name, systemFunctionSelector);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(abi.encode(functionSelector));

    _store.setRecord(_tableId, _keyTuple, _data);
  }

  /** Decode the tightly packed blob using this table's schema */
  function decode(
    bytes memory _blob
  ) internal pure returns (bytes16 namespace, bytes16 name, bytes4 systemFunctionSelector) {
    namespace = (Bytes.slice16(_blob, 0));

    name = (Bytes.slice16(_blob, 16));

    systemFunctionSelector = (Bytes.slice4(_blob, 32));
  }

  /** Tightly pack full data using this table's schema */
  function encode(bytes16 namespace, bytes16 name, bytes4 systemFunctionSelector) internal view returns (bytes memory) {
    return abi.encodePacked(namespace, name, systemFunctionSelector);
  }

  /** Encode keys as a bytes32 array using this table's schema */
  function encodeKeyTuple(bytes4 functionSelector) internal pure returns (bytes32[] memory _keyTuple) {
    _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(abi.encode(functionSelector));
  }

  /* Delete all data for given keys */
  function deleteRecord(bytes4 functionSelector) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(abi.encode(functionSelector));

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /* Delete all data for given keys (using the specified store) */
  function deleteRecord(IStore _store, bytes4 functionSelector) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(abi.encode(functionSelector));

    _store.deleteRecord(_tableId, _keyTuple);
  }
}
