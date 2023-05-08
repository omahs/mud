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

bytes32 constant _tableId = bytes32(abi.encodePacked(bytes16(""), bytes16("Singleton")));
bytes32 constant SingletonTableId = _tableId;

library Singleton {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](4);
    _schema[0] = SchemaType.INT256;
    _schema[1] = SchemaType.UINT32_ARRAY;
    _schema[2] = SchemaType.UINT32_ARRAY;
    _schema[3] = SchemaType.UINT32_ARRAY;

    return SchemaLib.encode(_schema);
  }

  function getKeySchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](0);

    return SchemaLib.encode(_schema);
  }

  /** Get the table's metadata */
  function getMetadata() internal pure returns (string memory, string[] memory) {
    string[] memory _fieldNames = new string[](4);
    _fieldNames[0] = "v1";
    _fieldNames[1] = "v2";
    _fieldNames[2] = "v3";
    _fieldNames[3] = "v4";
    return ("Singleton", _fieldNames);
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

  /** Get v1 */
  function getV1() internal view returns (int256 v1) {
    bytes32[] memory _primaryKeys = encodeKey();
    bytes memory _blob = StoreSwitch.getField(_tableId, _primaryKeys, 0);
    return (int256(uint256(Bytes.slice32(_blob, 0))));
  }

  /** Get v1 (using the specified store) */
  function getV1(IStore _store) internal view returns (int256 v1) {
    bytes32[] memory _primaryKeys = encodeKey();
    bytes memory _blob = _store.getField(_tableId, _primaryKeys, 0);
    return (int256(uint256(Bytes.slice32(_blob, 0))));
  }

  /** Set v1 */
  function setV1(int256 v1) internal {
    bytes32[] memory _primaryKeys = encodeKey();
    StoreSwitch.setField(_tableId, _primaryKeys, 0, abi.encodePacked((v1)));
  }

  /** Set v1 (using the specified store) */
  function setV1(IStore _store, int256 v1) internal {
    bytes32[] memory _primaryKeys = encodeKey();
    _store.setField(_tableId, _primaryKeys, 0, abi.encodePacked((v1)));
  }

  /** Get v2 */
  function getV2() internal view returns (uint32[2] memory v2) {
    bytes32[] memory _primaryKeys = encodeKey();
    bytes memory _blob = StoreSwitch.getField(_tableId, _primaryKeys, 1);
    return toStaticArray_uint32_2(SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint32());
  }

  /** Get v2 (using the specified store) */
  function getV2(IStore _store) internal view returns (uint32[2] memory v2) {
    bytes32[] memory _primaryKeys = encodeKey();
    bytes memory _blob = _store.getField(_tableId, _primaryKeys, 1);
    return toStaticArray_uint32_2(SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint32());
  }

  /** Set v2 */
  function setV2(uint32[2] memory v2) internal {
    bytes32[] memory _primaryKeys = encodeKey();
    StoreSwitch.setField(_tableId, _primaryKeys, 1, EncodeArray.encode(fromStaticArray_uint32_2(v2)));
  }

  /** Set v2 (using the specified store) */
  function setV2(IStore _store, uint32[2] memory v2) internal {
    bytes32[] memory _primaryKeys = encodeKey();
    _store.setField(_tableId, _primaryKeys, 1, EncodeArray.encode(fromStaticArray_uint32_2(v2)));
  }

  /** Push an element to v2 */
  function pushV2(uint32 _element) internal {
    bytes32[] memory _primaryKeys = encodeKey();
    StoreSwitch.pushToField(_tableId, _primaryKeys, 1, abi.encodePacked((_element)));
  }

  /** Push an element to v2 (using the specified store) */
  function pushV2(IStore _store, uint32 _element) internal {
    bytes32[] memory _primaryKeys = encodeKey();
    _store.pushToField(_tableId, _primaryKeys, 1, abi.encodePacked((_element)));
  }

  /** Pop an element from v2 */
  function popV2() internal {
    bytes32[] memory _primaryKeys = encodeKey();
    StoreSwitch.popFromField(_tableId, _primaryKeys, 1, 4);
  }

  /** Pop an element from v2 (using the specified store) */
  function popV2(IStore _store) internal {
    bytes32[] memory _primaryKeys = encodeKey();
    _store.popFromField(_tableId, _primaryKeys, 1, 4);
  }

  /** Update an element of v2 at `_index` */
  function updateV2(uint256 _index, uint32 _element) internal {
    bytes32[] memory _primaryKeys = encodeKey();
    StoreSwitch.updateInField(_tableId, _primaryKeys, 1, _index * 4, abi.encodePacked((_element)));
  }

  /** Update an element of v2 (using the specified store) at `_index` */
  function updateV2(IStore _store, uint256 _index, uint32 _element) internal {
    bytes32[] memory _primaryKeys = encodeKey();
    _store.updateInField(_tableId, _primaryKeys, 1, _index * 4, abi.encodePacked((_element)));
  }

  /** Get v3 */
  function getV3() internal view returns (uint32[2] memory v3) {
    bytes32[] memory _primaryKeys = encodeKey();
    bytes memory _blob = StoreSwitch.getField(_tableId, _primaryKeys, 2);
    return toStaticArray_uint32_2(SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint32());
  }

  /** Get v3 (using the specified store) */
  function getV3(IStore _store) internal view returns (uint32[2] memory v3) {
    bytes32[] memory _primaryKeys = encodeKey();
    bytes memory _blob = _store.getField(_tableId, _primaryKeys, 2);
    return toStaticArray_uint32_2(SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint32());
  }

  /** Set v3 */
  function setV3(uint32[2] memory v3) internal {
    bytes32[] memory _primaryKeys = encodeKey();
    StoreSwitch.setField(_tableId, _primaryKeys, 2, EncodeArray.encode(fromStaticArray_uint32_2(v3)));
  }

  /** Set v3 (using the specified store) */
  function setV3(IStore _store, uint32[2] memory v3) internal {
    bytes32[] memory _primaryKeys = encodeKey();
    _store.setField(_tableId, _primaryKeys, 2, EncodeArray.encode(fromStaticArray_uint32_2(v3)));
  }

  /** Push an element to v3 */
  function pushV3(uint32 _element) internal {
    bytes32[] memory _primaryKeys = encodeKey();
    StoreSwitch.pushToField(_tableId, _primaryKeys, 2, abi.encodePacked((_element)));
  }

  /** Push an element to v3 (using the specified store) */
  function pushV3(IStore _store, uint32 _element) internal {
    bytes32[] memory _primaryKeys = encodeKey();
    _store.pushToField(_tableId, _primaryKeys, 2, abi.encodePacked((_element)));
  }

  /** Pop an element from v3 */
  function popV3() internal {
    bytes32[] memory _primaryKeys = encodeKey();
    StoreSwitch.popFromField(_tableId, _primaryKeys, 2, 4);
  }

  /** Pop an element from v3 (using the specified store) */
  function popV3(IStore _store) internal {
    bytes32[] memory _primaryKeys = encodeKey();
    _store.popFromField(_tableId, _primaryKeys, 2, 4);
  }

  /** Update an element of v3 at `_index` */
  function updateV3(uint256 _index, uint32 _element) internal {
    bytes32[] memory _primaryKeys = encodeKey();
    StoreSwitch.updateInField(_tableId, _primaryKeys, 2, _index * 4, abi.encodePacked((_element)));
  }

  /** Update an element of v3 (using the specified store) at `_index` */
  function updateV3(IStore _store, uint256 _index, uint32 _element) internal {
    bytes32[] memory _primaryKeys = encodeKey();
    _store.updateInField(_tableId, _primaryKeys, 2, _index * 4, abi.encodePacked((_element)));
  }

  /** Get v4 */
  function getV4() internal view returns (uint32[1] memory v4) {
    bytes32[] memory _primaryKeys = encodeKey();
    bytes memory _blob = StoreSwitch.getField(_tableId, _primaryKeys, 3);
    return toStaticArray_uint32_1(SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint32());
  }

  /** Get v4 (using the specified store) */
  function getV4(IStore _store) internal view returns (uint32[1] memory v4) {
    bytes32[] memory _primaryKeys = encodeKey();
    bytes memory _blob = _store.getField(_tableId, _primaryKeys, 3);
    return toStaticArray_uint32_1(SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint32());
  }

  /** Set v4 */
  function setV4(uint32[1] memory v4) internal {
    bytes32[] memory _primaryKeys = encodeKey();
    StoreSwitch.setField(_tableId, _primaryKeys, 3, EncodeArray.encode(fromStaticArray_uint32_1(v4)));
  }

  /** Set v4 (using the specified store) */
  function setV4(IStore _store, uint32[1] memory v4) internal {
    bytes32[] memory _primaryKeys = encodeKey();
    _store.setField(_tableId, _primaryKeys, 3, EncodeArray.encode(fromStaticArray_uint32_1(v4)));
  }

  /** Push an element to v4 */
  function pushV4(uint32 _element) internal {
    bytes32[] memory _primaryKeys = encodeKey();
    StoreSwitch.pushToField(_tableId, _primaryKeys, 3, abi.encodePacked((_element)));
  }

  /** Push an element to v4 (using the specified store) */
  function pushV4(IStore _store, uint32 _element) internal {
    bytes32[] memory _primaryKeys = encodeKey();
    _store.pushToField(_tableId, _primaryKeys, 3, abi.encodePacked((_element)));
  }

  /** Pop an element from v4 */
  function popV4() internal {
    bytes32[] memory _primaryKeys = encodeKey();
    StoreSwitch.popFromField(_tableId, _primaryKeys, 3, 4);
  }

  /** Pop an element from v4 (using the specified store) */
  function popV4(IStore _store) internal {
    bytes32[] memory _primaryKeys = encodeKey();
    _store.popFromField(_tableId, _primaryKeys, 3, 4);
  }

  /** Update an element of v4 at `_index` */
  function updateV4(uint256 _index, uint32 _element) internal {
    bytes32[] memory _primaryKeys = encodeKey();
    StoreSwitch.updateInField(_tableId, _primaryKeys, 3, _index * 4, abi.encodePacked((_element)));
  }

  /** Update an element of v4 (using the specified store) at `_index` */
  function updateV4(IStore _store, uint256 _index, uint32 _element) internal {
    bytes32[] memory _primaryKeys = encodeKey();
    _store.updateInField(_tableId, _primaryKeys, 3, _index * 4, abi.encodePacked((_element)));
  }

  /** Get the full data */
  function get() internal view returns (int256 v1, uint32[2] memory v2, uint32[2] memory v3, uint32[1] memory v4) {
    bytes32[] memory _primaryKeys = encodeKey();

    bytes memory _blob = StoreSwitch.getRecord(_tableId, _primaryKeys, getSchema());
    return decode(_blob);
  }

  /** Get the full data (using the specified store) */
  function get(
    IStore _store
  ) internal view returns (int256 v1, uint32[2] memory v2, uint32[2] memory v3, uint32[1] memory v4) {
    bytes32[] memory _primaryKeys = encodeKey();

    bytes memory _blob = _store.getRecord(_tableId, _primaryKeys, getSchema());
    return decode(_blob);
  }

  /** Set the full data using individual values */
  function set(int256 v1, uint32[2] memory v2, uint32[2] memory v3, uint32[1] memory v4) internal {
    bytes memory _data = encode(v1, v2, v3, v4);
    bytes32[] memory _primaryKeys = encodeKey();

    StoreSwitch.setRecord(_tableId, _primaryKeys, _data);
  }

  /** Set the full data using individual values (using the specified store) */
  function set(IStore _store, int256 v1, uint32[2] memory v2, uint32[2] memory v3, uint32[1] memory v4) internal {
    bytes memory _data = encode(v1, v2, v3, v4);
    bytes32[] memory _primaryKeys = encodeKey();

    _store.setRecord(_tableId, _primaryKeys, _data);
  }

  /** Decode the tightly packed blob using this table's schema */
  function decode(
    bytes memory _blob
  ) internal view returns (int256 v1, uint32[2] memory v2, uint32[2] memory v3, uint32[1] memory v4) {
    // 32 is the total byte length of static data
    PackedCounter _encodedLengths = PackedCounter.wrap(Bytes.slice32(_blob, 32));

    v1 = (int256(uint256(Bytes.slice32(_blob, 0))));

    // Store trims the blob if dynamic fields are all empty
    if (_blob.length > 32) {
      uint256 _start;
      // skip static data length + dynamic lengths word
      uint256 _end = 64;

      _start = _end;
      _end += _encodedLengths.atIndex(0);
      v2 = toStaticArray_uint32_2(SliceLib.getSubslice(_blob, _start, _end).decodeArray_uint32());

      _start = _end;
      _end += _encodedLengths.atIndex(1);
      v3 = toStaticArray_uint32_2(SliceLib.getSubslice(_blob, _start, _end).decodeArray_uint32());

      _start = _end;
      _end += _encodedLengths.atIndex(2);
      v4 = toStaticArray_uint32_1(SliceLib.getSubslice(_blob, _start, _end).decodeArray_uint32());
    }
  }

  /** Tightly pack full data using this table's schema */
  function encode(
    int256 v1,
    uint32[2] memory v2,
    uint32[2] memory v3,
    uint32[1] memory v4
  ) internal view returns (bytes memory) {
    uint16[] memory _counters = new uint16[](3);
    _counters[0] = uint16(v2.length * 4);
    _counters[1] = uint16(v3.length * 4);
    _counters[2] = uint16(v4.length * 4);
    PackedCounter _encodedLengths = PackedCounterLib.pack(_counters);

    return
      abi.encodePacked(
        v1,
        _encodedLengths.unwrap(),
        EncodeArray.encode(fromStaticArray_uint32_2(v2)),
        EncodeArray.encode(fromStaticArray_uint32_2(v3)),
        EncodeArray.encode(fromStaticArray_uint32_1(v4))
      );
  }

  function encodeKey() internal pure returns (bytes32[] memory _primaryKeys) {
    _primaryKeys = new bytes32[](0);

    return _primaryKeys;
  }

  /* Delete all data for given keys */
  function deleteRecord() internal {
    bytes32[] memory _primaryKeys = encodeKey();
    StoreSwitch.deleteRecord(_tableId, _primaryKeys);
  }

  /* Delete all data for given keys (using the specified store) */
  function deleteRecord(IStore _store) internal {
    bytes32[] memory _primaryKeys = encodeKey();
    _store.deleteRecord(_tableId, _primaryKeys);
  }
}

function toStaticArray_uint32_2(uint32[] memory _value) pure returns (uint32[2] memory _result) {
  // in memory static arrays are just dynamic arrays without the length byte
  assembly {
    _result := add(_value, 0x20)
  }
}

function toStaticArray_uint32_1(uint32[] memory _value) pure returns (uint32[1] memory _result) {
  // in memory static arrays are just dynamic arrays without the length byte
  assembly {
    _result := add(_value, 0x20)
  }
}

function fromStaticArray_uint32_2(uint32[2] memory _value) view returns (uint32[] memory _result) {
  _result = new uint32[](2);
  uint256 fromPointer;
  uint256 toPointer;
  assembly {
    fromPointer := _value
    toPointer := add(_result, 0x20)
  }
  Memory.copy(fromPointer, toPointer, 64);
}

function fromStaticArray_uint32_1(uint32[1] memory _value) view returns (uint32[] memory _result) {
  _result = new uint32[](1);
  uint256 fromPointer;
  uint256 toPointer;
  assembly {
    fromPointer := _value
    toPointer := add(_result, 0x20)
  }
  Memory.copy(fromPointer, toPointer, 32);
}
