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

library AddressArray {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](1);
    _schema[0] = SchemaType.ADDRESS_ARRAY;

    return SchemaLib.encode(_schema);
  }

  function getKeySchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](1);
    _schema[0] = SchemaType.BYTES32;

    return SchemaLib.encode(_schema);
  }

  /** Get the table's metadata */
  function getMetadata() internal pure returns (string memory, string[] memory) {
    string[] memory _fieldNames = new string[](1);
    _fieldNames[0] = "value";
    return ("AddressArray", _fieldNames);
  }

  /** Register the table's schema */
  function registerSchema(bytes32 _tableId) internal {
    StoreSwitch.registerSchema(_tableId, getSchema(), getKeySchema());
  }

  /** Register the table's schema (using the specified store) */
  function registerSchema(IStore _store, bytes32 _tableId) internal {
    _store.registerSchema(_tableId, getSchema(), getKeySchema());
  }

  /** Set the table's metadata */
  function setMetadata(bytes32 _tableId) internal {
    (string memory _tableName, string[] memory _fieldNames) = getMetadata();
    StoreSwitch.setMetadata(_tableId, _tableName, _fieldNames);
  }

  /** Set the table's metadata (using the specified store) */
  function setMetadata(IStore _store, bytes32 _tableId) internal {
    (string memory _tableName, string[] memory _fieldNames) = getMetadata();
    _store.setMetadata(_tableId, _tableName, _fieldNames);
  }

  /** Get value */
  function get(bytes32 _tableId, bytes32 key) internal view returns (address[] memory value) {
    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32((key));

    bytes memory _blob = StoreSwitch.getField(_tableId, _primaryKeys, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_address());
  }

  /** Get value (using the specified store) */
  function get(IStore _store, bytes32 _tableId, bytes32 key) internal view returns (address[] memory value) {
    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32((key));

    bytes memory _blob = _store.getField(_tableId, _primaryKeys, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_address());
  }

  /** Set value */
  function set(bytes32 _tableId, bytes32 key, address[] memory value) internal {
    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32((key));

    StoreSwitch.setField(_tableId, _primaryKeys, 0, EncodeArray.encode((value)));
  }

  /** Set value (using the specified store) */
  function set(IStore _store, bytes32 _tableId, bytes32 key, address[] memory value) internal {
    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32((key));

    _store.setField(_tableId, _primaryKeys, 0, EncodeArray.encode((value)));
  }

  /** Push an element to value */
  function push(bytes32 _tableId, bytes32 key, address _element) internal {
    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32((key));

    StoreSwitch.pushToField(_tableId, _primaryKeys, 0, abi.encodePacked((_element)));
  }

  /** Push an element to value (using the specified store) */
  function push(IStore _store, bytes32 _tableId, bytes32 key, address _element) internal {
    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32((key));

    _store.pushToField(_tableId, _primaryKeys, 0, abi.encodePacked((_element)));
  }

  /** Update an element of value at `_index` */
  function update(bytes32 _tableId, bytes32 key, uint256 _index, address _element) internal {
    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32((key));

    StoreSwitch.updateInField(_tableId, _primaryKeys, 0, _index * 20, abi.encodePacked((_element)));
  }

  /** Update an element of value (using the specified store) at `_index` */
  function update(IStore _store, bytes32 _tableId, bytes32 key, uint256 _index, address _element) internal {
    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32((key));

    _store.updateInField(_tableId, _primaryKeys, 0, _index * 20, abi.encodePacked((_element)));
  }

  /** Tightly pack full data using this table's schema */
  function encode(address[] memory value) internal view returns (bytes memory) {
    uint16[] memory _counters = new uint16[](1);
    _counters[0] = uint16(value.length * 20);
    PackedCounter _encodedLengths = PackedCounterLib.pack(_counters);

    return abi.encodePacked(_encodedLengths.unwrap(), EncodeArray.encode((value)));
  }

  /* Delete all data for given keys */
  function deleteRecord(bytes32 _tableId, bytes32 key) internal {
    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32((key));

    StoreSwitch.deleteRecord(_tableId, _primaryKeys);
  }

  /* Delete all data for given keys (using the specified store) */
  function deleteRecord(IStore _store, bytes32 _tableId, bytes32 key) internal {
    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32((key));

    _store.deleteRecord(_tableId, _primaryKeys);
  }
}
