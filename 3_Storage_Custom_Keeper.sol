// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// KeeperCompatible.sol imports the functions from both ./KeeperBase.sol and
// ./interfaces/KeeperCompatibleInterface.sol
import "@chainlink/contracts/src/v0.8/KeeperCompatible.sol";


contract Storage is KeeperCompatibleInterface {

    uint256 public number;

    // Use an interval in seconds and a timestamp to slow execution of Upkeep
    uint public immutable interval;
    uint public lastTimeStamp;

    constructor(uint updateInterval) {
      interval = updateInterval;
      lastTimeStamp = block.timestamp;

      // initialize number 
      number = 0;
    }

    // check upkeep decides whether to perform upkeep
    function checkUpkeep(bytes calldata checkData) external view override returns (bool upkeepNeeded, bytes memory performData) {
        upkeepNeeded = (block.timestamp - lastTimeStamp) > interval;
        performData = checkData;
    }

    function performUpkeep(bytes calldata /* performData */) external override {
        number = number + 10;
    }
}
