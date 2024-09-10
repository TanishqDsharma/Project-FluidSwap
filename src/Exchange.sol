// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {IERC20} from "../lib/openzeppelin-contracts/contracts/interfaces/IERC20.sol";

contract Exchange{

address public tokenAddress;

constructor(address _token){
    require(_token!=address(0),"Invalid Token Address");
    tokenAddress=_token;
}

function addLiquidity(uint256 _tokenAmount) public{
    IERC20 token = IERC20(tokenAddress);
    token.transferFrom(msg.sender,address(this),_tokenAmount);
} 


function getReserve() public view returns(uint256){
    return IERC20(tokenAddress).balanceOf(address(this));
}

}