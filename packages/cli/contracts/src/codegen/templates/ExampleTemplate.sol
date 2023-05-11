// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/* Autogenerated file. Do not edit manually. */

import { IStore } from "@latticexyz/store/src/IStore.sol";
import { TemplateContent } from "@latticexyz/world/src/modules/templates/tables/TemplateContent.sol";
import { TemplateIndex } from "@latticexyz/world/src/modules/templates/tables/TemplateIndex.sol";
import { Enum1, Enum2 } from "../Types.sol";
import { Statics, StaticsTableId, StaticsData } from "../tables/Statics.sol";

bytes32 constant templateId = "Example";
bytes32 constant ExampleTemplateId = templateId;
uint256 constant LENGTH = 1;

function ExampleTemplate() {
  bytes32[] memory tableIds = new bytes32[](LENGTH);
  tableIds[0] = StaticsTableId;
  TemplateIndex.set(templateId, tableIds);

  TemplateContent.set(
    templateId,
    StaticsTableId,
    Statics.encode(1, 1, "wasd", 0x71C7656EC7ab88b098defB751B7401B5f6d8976F, true, Enum1.E1, Enum2.E1)
  );
}

function ExampleTemplate(IStore store) {
  bytes32[] memory tableIds = new bytes32[](LENGTH);
  tableIds[0] = StaticsTableId;
  TemplateIndex.set(store, templateId, tableIds);

  TemplateContent.set(
    store,
    templateId,
    StaticsTableId,
    Statics.encode(1, 1, "wasd", 0x71C7656EC7ab88b098defB751B7401B5f6d8976F, true, Enum1.E1, Enum2.E1)
  );
}