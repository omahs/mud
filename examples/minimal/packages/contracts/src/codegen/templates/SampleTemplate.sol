// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/* Autogenerated file. Do not edit manually. */

import { IStore } from "@latticexyz/store/src/IStore.sol";
import { TemplateContent } from "@latticexyz/world/src/modules/templates/tables/TemplateContent.sol";
import { TemplateIndex } from "@latticexyz/world/src/modules/templates/tables/TemplateIndex.sol";

import { CounterTable, CounterTableTableId } from "../tables/CounterTable.sol";

bytes32 constant templateId = "Sample";
bytes32 constant SampleTemplateId = templateId;
uint256 constant LENGTH = 1;

function SampleTemplate() {
  bytes32[] memory tableIds = new bytes32[](LENGTH);
  tableIds[0] = CounterTableTableId;
  TemplateIndex.set(templateId, tableIds);

  TemplateContent.set(templateId, CounterTableTableId, CounterTable.encode(420));
}

function SampleTemplate(IStore store) {
  bytes32[] memory tableIds = new bytes32[](LENGTH);
  tableIds[0] = CounterTableTableId;
  TemplateIndex.set(store, templateId, tableIds);

  TemplateContent.set(store, templateId, CounterTableTableId, CounterTable.encode(420));
}