// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/* Autogenerated file. Do not edit manually. */

import { IStore } from "@latticexyz/store/src/IStore.sol";
import { IWorldKernel } from "../interfaces/IWorldKernel.sol";
import { IWorldEphemeral } from "../interfaces/IWorldEphemeral.sol";

import { ICoreSystem } from "./ICoreSystem.sol";
import { IAccessManagementSystem } from "./IAccessManagementSystem.sol";
import { IModuleInstallationSystem } from "./IModuleInstallationSystem.sol";
import { IWorldRegistrationSystem } from "./IWorldRegistrationSystem.sol";

/**
 * The IBaseWorld interface includes all systems dynamically added to the World
 * during the deploy process.
 */
interface IBaseWorld is
  IStore,
  IWorldKernel,
  IWorldEphemeral,
  ICoreSystem,
  IAccessManagementSystem,
  IModuleInstallationSystem,
  IWorldRegistrationSystem
{

}
