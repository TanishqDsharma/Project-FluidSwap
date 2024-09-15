// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {IERC20} from "../lib/openzeppelin-contracts/contracts/interfaces/IERC20.sol";

contract Exchange{

address public tokenAddress;

constructor(address _token){
    require(_token!=address(0),"Invalid Token Address");
    tokenAddress=_token;
}

function addLiquidity(uint256 _tokenAmount) public payable{
    IERC20 token = IERC20(tokenAddress);
    token.transferFrom(msg.sender,address(this),_tokenAmount);
} 


function getPrice(
    uint256 inputReserve, 
    uint256 outputReserve) public pure returns(uint256){

        require(inputReserve>0&&outputReserve>0,"Not enough in the Reserves");
        return (inputReserve*1000)/outputReserve;
}


function getAmount(
    uint256 inputAmount,
    uint256 inputReserve,
    uint256 outputReserve
) private pure returns(uint256){

    require(inputReserve>0&&outputReserve>0,"Not enough in the Reserves");
    return (inputAmount*inputReserve)/(inputReserve+inputAmount);

}

function getTokenAmount(
    uint256 _ethSold
) public view returns(uint256) {
    require(_ethSold>0,"ethSold is very small");
    uint256 tokenReserve = getReserve();
    return getAmount(_ethSold,tokenReserve,address(this).balance);
}

function getReserve() public view returns(uint256){
    return IERC20(tokenAddress).balanceOf(address(this));
}


}