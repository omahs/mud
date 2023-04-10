// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { IStoreHook } from "./IStore.sol";
import { IStoreDynamicPartial } from "./IStoreDynamicPartial.sol";
import { StoreCore } from "./StoreCore.sol";
import { Schema } from "./Schema.sol";
import { Store } from "./Store.sol";

// Not abstract, so that it can be used as a base contract for testing and wherever write access is not needed
contract StoreView is Store, IStoreDynamicPartial {
  error StoreView_NotImplemented();

  /**
   * Not implemented in StoreView
   */
  function registerSchema(uint256, Schema, Schema) public virtual {
    revert StoreView_NotImplemented();
  }

  /**
   * Not implemented in StoreView
   */
  function setMetadata(uint256, string calldata, string[] calldata) public virtual {
    revert StoreView_NotImplemented();
  }

  /**
   * Not implemented in StoreView
   */
  function setRecord(uint256, bytes32[] calldata, bytes calldata) public virtual {
    revert StoreView_NotImplemented();
  }

  /**
   * Not implemented in StoreView
   */
  function setField(uint256, bytes32[] calldata, uint8, bytes calldata) public virtual {
    revert StoreView_NotImplemented();
  }

  /**
   * Not implemented in StoreView
   */
  function registerStoreHook(uint256, IStoreHook) public virtual {
    revert StoreView_NotImplemented();
  }

  /**
   * Not implemented in StoreView
   */
  function deleteRecord(uint256, bytes32[] calldata) public virtual {
    revert StoreView_NotImplemented();
  }

  /************************************************************************
   *
   *    DynamicPartial
   *
   ************************************************************************/

  /**
   * Not implemented in StoreView
   */
  function pushToField(uint256, bytes32[] calldata, uint8, bytes calldata) public virtual {
    revert StoreView_NotImplemented();
  }

  /**
   * Not implemented in StoreView
   */
  function updateInField(uint256, bytes32[] calldata, uint8, uint256, bytes calldata) public virtual {
    revert StoreView_NotImplemented();
  }
}
