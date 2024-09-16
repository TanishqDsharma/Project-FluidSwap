// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {IERC20} from "../lib/openzeppelin-contracts/contracts/interfaces/IERC20.sol";
import {ERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";



contract Exchange is ERC20{

address public tokenAddress;

constructor(address _token) ERC20("Zswap-V1", "ZSP"){
    require(_token!=address(0),"Invalid Token Address");
    tokenAddress=_token;
}

function addLiquidity(uint256 _tokenAmount) public payable returns(uint256){
    if(getReserve()==0){
        IERC20 token = IERC20(tokenAddress);
        token.transferFrom(msg.sender,address(this),_tokenAmount);
        // Since, the pool is being intialized the amount of liqudity
        // is equal to the amount of ETH in the pool. 
        // Example: If the user sent 10 ETH, liquidity = 10.
        uint256 liquidity = address(this).balance;
        _mint(msg.sender, liquidity);
        return liquidity;

    }else{
        uint256 ethReserve = address(this).balance - msg.value;
        uint256 tokenReserve = getReserve();
        // Here, tokenAmount is the amount of tokens that the user needs to provide to 
        // maintain the same ETH-to-token ratio in the pool.
        uint256 tokenAmount = msg.value*tokenReserve/ethReserve;
        require(_tokenAmount >= tokenAmount, "insufficient token amount");
        IERC20 token = IERC20(tokenAddress);
        token.transferFrom(msg.sender, address(this), tokenAmount);  
        //The LP tokens (liquidity) issued are proportional to the ETH the user is adding, relative to the total ETH reserve.
        
        uint256 liquidity = (totalSupply() * msg.value) / ethReserve;
        _mint(msg.sender, liquidity);
        return liquidity;
      
    }
} 


// Swapping Functions

function ethToTokenSwap(uint256 _minTokens) public payable{
    // 1. Getting Token Reserve
    uint256 tokenReserve = getReserve();
    uint256 tokensBought = getAmount(msg.value,address(this).balance-msg.value,tokenReserve);
    require(tokensBought>=_minTokens,"Insufficient Output Amount");
    IERC20(tokenAddress).transfer(msg.sender,tokensBought);

}



function TokenToETHSwap(uint256 _tokensSold,uint256 _minEth) public payable{
    // 1. Getting Token Reserve
    uint256 tokenReserve = getReserve();
    uint256 ethBought = getAmount(_tokensSold,tokenReserve,address(this).balance);
    require(ethBought>=_minEth,"Insufficient Output Amount");
    IERC20(tokenAddress).transferFrom(msg.sender,address(this),_tokensSold);
    payable(msg.sender).transfer(ethBought);

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

function getEthAmount(
    uint256 _tokenSold
) public view returns(uint256){
    require(_tokenSold>0,"tokenSold is very small");
    uint256 tokenReserve = getReserve();
    return getAmount(_tokenSold,tokenReserve,address(this).balance);
}



function getReserve() public view returns(uint256){
    return IERC20(tokenAddress).balanceOf(address(this));
}


}