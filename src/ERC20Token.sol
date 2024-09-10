// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {ERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";


contract ERC20Token is ERC20{


/**
 * @notice Initializes the ERC20 token contract with a name, symbol, and initial supply.
 * @dev The constructor inherits from the ERC20 contract and mints the initial supply to the deployer's address.
 * @param name The name of the token (e.g., "TokenName").
 * @param symbol The symbol of the token (e.g., "TKN").
 * @param initialSupply The initial amount of tokens to mint and assign to the deployer.
 */

    constructor(
        string memory name,
        string memory symbol, 
        uint256 initialSupply
    )ERC20(name,symbol){
        _mint(msg.sender,initialSupply);
    }
}