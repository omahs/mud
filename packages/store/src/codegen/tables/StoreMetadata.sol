// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/* Autogenerated file. Do not edit manually. */

// Import schema type
import { SchemaType } from "@latticexyz/schema-type/src/solidity/SchemaType.sol";

// Import store internals
import { IStore } from "../../IStore.sol";
import { IStoreDynamicPartial } from "../../IStoreDynamicPartial.sol";
import { StoreSwitch } from "../../StoreSwitch.sol";
import { StoreCore } from "../../StoreCore.sol";
import { Bytes } from "../../Bytes.sol";
import { Memory } from "../../Memory.sol";
import { SliceLib } from "../../Slice.sol";
import { EncodeArray } from "../../tightcoder/EncodeArray.sol";
import { Schema, SchemaLib } from "../../Schema.sol";
import { PackedCounter, PackedCounterLib } from "../../PackedCounter.sol";

uint256 constant _tableId = uint256(bytes32(abi.encodePacked(bytes16("mudstore"), bytes16("StoreMetadata"))));
uint256 constant StoreMetadataTableId = _tableId;

struct StoreMetadataData {
  string tableName;
  bytes abiEncodedFieldNames;
}

library StoreMetadata {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](2);
    _schema[0] = SchemaType.STRING;
    _schema[1] = SchemaType.BYTES;

    return SchemaLib.encode(_schema);
  }

  function getKeySchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](1);
    _schema[0] = SchemaType.UINT256;

    return SchemaLib.encode(_schema);
  }

  /** Get the table's metadata */
  function getMetadata() internal pure returns (string memory, string[] memory) {
    string[] memory _fieldNames = new string[](2);
    _fieldNames[0] = "tableName";
    _fieldNames[1] = "abiEncodedFieldNames";
    return ("StoreMetadata", _fieldNames);
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

  /** Get tableName */
  function getTableName(uint256 tableId) internal view returns (string memory tableName) {
    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32(uint256((tableId)));

    bytes memory _blob = StoreSwitch.getField(_tableId, _primaryKeys, 0);
    return (string(_blob));
  }

  /** Get tableName (using the specified store) */
  function getTableName(IStore _store, uint256 tableId) internal view returns (string memory tableName) {
    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32(uint256((tableId)));

    bytes memory _blob = _store.getField(_tableId, _primaryKeys, 0);
    return (string(_blob));
  }

  /** Set tableName */
  function setTableName(uint256 tableId, string memory tableName) internal {
    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32(uint256((tableId)));

    StoreSwitch.setField(_tableId, _primaryKeys, 0, bytes((tableName)));
  }

  /** Set tableName (using the specified store) */
  function setTableName(IStore _store, uint256 tableId, string memory tableName) internal {
    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32(uint256((tableId)));

    _store.setField(_tableId, _primaryKeys, 0, bytes((tableName)));
  }

  /** Push a slice to tableName */
  function pushTableName(uint256 tableId, string memory _slice) internal {
    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32(uint256((tableId)));

    StoreSwitch.pushToField(_tableId, _primaryKeys, 0, bytes((_slice)));
  }

  /** Push a slice to tableName (using the specified store) */
  function pushTableName(IStoreDynamicPartial _store, uint256 tableId, string memory _slice) internal {
    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32(uint256((tableId)));

    _store.pushToField(_tableId, _primaryKeys, 0, bytes((_slice)));
  }

  /** Update a slice of tableName at `_index` */
  function updateTableName(uint256 tableId, uint256 _index, string memory _slice) internal {
    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32(uint256((tableId)));

    StoreSwitch.updateInField(_tableId, _primaryKeys, 0, _index * 1, bytes((_slice)));
  }

  /** Update a slice of tableName (using the specified store) at `_index` */
  function updateTableName(
    IStoreDynamicPartial _store,
    uint256 tableId,
    uint256 _index,
    string memory _slice
  ) internal {
    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32(uint256((tableId)));

    _store.updateInField(_tableId, _primaryKeys, 0, _index * 1, bytes((_slice)));
  }

  /** Get abiEncodedFieldNames */
  function getAbiEncodedFieldNames(uint256 tableId) internal view returns (bytes memory abiEncodedFieldNames) {
    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32(uint256((tableId)));

    bytes memory _blob = StoreSwitch.getField(_tableId, _primaryKeys, 1);
    return (bytes(_blob));
  }

  /** Get abiEncodedFieldNames (using the specified store) */
  function getAbiEncodedFieldNames(
    IStore _store,
    uint256 tableId
  ) internal view returns (bytes memory abiEncodedFieldNames) {
    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32(uint256((tableId)));

    bytes memory _blob = _store.getField(_tableId, _primaryKeys, 1);
    return (bytes(_blob));
  }

  /** Set abiEncodedFieldNames */
  function setAbiEncodedFieldNames(uint256 tableId, bytes memory abiEncodedFieldNames) internal {
    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32(uint256((tableId)));

    StoreSwitch.setField(_tableId, _primaryKeys, 1, bytes((abiEncodedFieldNames)));
  }

  /** Set abiEncodedFieldNames (using the specified store) */
  function setAbiEncodedFieldNames(IStore _store, uint256 tableId, bytes memory abiEncodedFieldNames) internal {
    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32(uint256((tableId)));

    _store.setField(_tableId, _primaryKeys, 1, bytes((abiEncodedFieldNames)));
  }

  /** Push a slice to abiEncodedFieldNames */
  function pushAbiEncodedFieldNames(uint256 tableId, bytes memory _slice) internal {
    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32(uint256((tableId)));

    StoreSwitch.pushToField(_tableId, _primaryKeys, 1, bytes((_slice)));
  }

  /** Push a slice to abiEncodedFieldNames (using the specified store) */
  function pushAbiEncodedFieldNames(IStoreDynamicPartial _store, uint256 tableId, bytes memory _slice) internal {
    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32(uint256((tableId)));

    _store.pushToField(_tableId, _primaryKeys, 1, bytes((_slice)));
  }

  /** Update a slice of abiEncodedFieldNames at `_index` */
  function updateAbiEncodedFieldNames(uint256 tableId, uint256 _index, bytes memory _slice) internal {
    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32(uint256((tableId)));

    StoreSwitch.updateInField(_tableId, _primaryKeys, 1, _index * 1, bytes((_slice)));
  }

  /** Update a slice of abiEncodedFieldNames (using the specified store) at `_index` */
  function updateAbiEncodedFieldNames(
    IStoreDynamicPartial _store,
    uint256 tableId,
    uint256 _index,
    bytes memory _slice
  ) internal {
    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32(uint256((tableId)));

    _store.updateInField(_tableId, _primaryKeys, 1, _index * 1, bytes((_slice)));
  }

  /** Get the full data */
  function get(uint256 tableId) internal view returns (StoreMetadataData memory _table) {
    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32(uint256((tableId)));

    bytes memory _blob = StoreSwitch.getRecord(_tableId, _primaryKeys, getSchema());
    return decode(_blob);
  }

  /** Get the full data (using the specified store) */
  function get(IStore _store, uint256 tableId) internal view returns (StoreMetadataData memory _table) {
    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32(uint256((tableId)));

    bytes memory _blob = _store.getRecord(_tableId, _primaryKeys, getSchema());
    return decode(_blob);
  }

  /** Set the full data using individual values */
  function set(uint256 tableId, string memory tableName, bytes memory abiEncodedFieldNames) internal {
    bytes memory _data = encode(tableName, abiEncodedFieldNames);

    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32(uint256((tableId)));

    StoreSwitch.setRecord(_tableId, _primaryKeys, _data);
  }

  /** Set the full data using individual values (using the specified store) */
  function set(IStore _store, uint256 tableId, string memory tableName, bytes memory abiEncodedFieldNames) internal {
    bytes memory _data = encode(tableName, abiEncodedFieldNames);

    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32(uint256((tableId)));

    _store.setRecord(_tableId, _primaryKeys, _data);
  }

  /** Set the full data using the data struct */
  function set(uint256 tableId, StoreMetadataData memory _table) internal {
    set(tableId, _table.tableName, _table.abiEncodedFieldNames);
  }

  /** Set the full data using the data struct (using the specified store) */
  function set(IStore _store, uint256 tableId, StoreMetadataData memory _table) internal {
    set(_store, tableId, _table.tableName, _table.abiEncodedFieldNames);
  }

  /** Decode the tightly packed blob using this table's schema */
  function decode(bytes memory _blob) internal view returns (StoreMetadataData memory _table) {
    // 0 is the total byte length of static data
    PackedCounter _encodedLengths = PackedCounter.wrap(Bytes.slice32(_blob, 0));

    // Store trims the blob if dynamic fields are all empty
    if (_blob.length > 0) {
      uint256 _start;
      // skip static data length + dynamic lengths word
      uint256 _end = 32;

      _start = _end;
      _end += _encodedLengths.atIndex(0);
      _table.tableName = (string(SliceLib.getSubslice(_blob, _start, _end).toBytes()));

      _start = _end;
      _end += _encodedLengths.atIndex(1);
      _table.abiEncodedFieldNames = (bytes(SliceLib.getSubslice(_blob, _start, _end).toBytes()));
    }
  }

  /** Tightly pack full data using this table's schema */
  function encode(string memory tableName, bytes memory abiEncodedFieldNames) internal view returns (bytes memory) {
    uint16[] memory _counters = new uint16[](2);
    _counters[0] = uint16(bytes(tableName).length);
    _counters[1] = uint16(bytes(abiEncodedFieldNames).length);
    PackedCounter _encodedLengths = PackedCounterLib.pack(_counters);

    return abi.encodePacked(_encodedLengths.unwrap(), bytes((tableName)), bytes((abiEncodedFieldNames)));
  }

  /* Delete all data for given keys */
  function deleteRecord(uint256 tableId) internal {
    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32(uint256((tableId)));

    StoreSwitch.deleteRecord(_tableId, _primaryKeys);
  }

  /* Delete all data for given keys (using the specified store) */
  function deleteRecord(IStore _store, uint256 tableId) internal {
    bytes32[] memory _primaryKeys = new bytes32[](1);
    _primaryKeys[0] = bytes32(uint256((tableId)));

    _store.deleteRecord(_tableId, _primaryKeys);
  }
}
