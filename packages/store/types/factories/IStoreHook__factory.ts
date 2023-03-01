/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import { Contract, Signer, utils } from "ethers";
import { Provider } from "@ethersproject/providers";
import type { IStoreHook, IStoreHookInterface } from "../IStoreHook";

const _abi = [
  {
    inputs: [
      {
        internalType: "uint256",
        name: "table",
        type: "uint256",
      },
      {
        internalType: "bytes32[]",
        name: "key",
        type: "bytes32[]",
      },
    ],
    name: "onDeleteRecord",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "table",
        type: "uint256",
      },
      {
        internalType: "bytes32[]",
        name: "key",
        type: "bytes32[]",
      },
      {
        internalType: "uint8",
        name: "schemaIndex",
        type: "uint8",
      },
      {
        internalType: "bytes",
        name: "data",
        type: "bytes",
      },
    ],
    name: "onSetField",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "table",
        type: "uint256",
      },
      {
        internalType: "bytes32[]",
        name: "key",
        type: "bytes32[]",
      },
      {
        internalType: "bytes",
        name: "data",
        type: "bytes",
      },
    ],
    name: "onSetRecord",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
];

export class IStoreHook__factory {
  static readonly abi = _abi;
  static createInterface(): IStoreHookInterface {
    return new utils.Interface(_abi) as IStoreHookInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): IStoreHook {
    return new Contract(address, _abi, signerOrProvider) as IStoreHook;
  }
}