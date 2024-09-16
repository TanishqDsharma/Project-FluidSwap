// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import "./Exchange.sol";

contract Factory{

   
    /// @dev This mapping allows to find exchanges via their tokens 
    mapping(address=>address) public tokenToExchange;

    /// @notice This function allows users to create and deploy an exchange
    /// @param _tokenAddress Simply takes a tokenAddress  
    
    function createExchange(address _tokenAddress) public returns(address){

        // First check, ensures the tokenAddress is not a zero Address.
        require(_tokenAddress!=address(0),"Please Provide a valid token Address");
        
        // Second check, ensures the tokenAddress hasn't already been added to the registry. NOTE: The idea of not having multiple
        // exchanges for same token is because we don’t want liquidity to be scattered across multiple exchanges.It should better 
        // be concentrated on one exchange to reduce slippage and provide better exchange rates.
        require(tokenToExchange[_tokenAddress]==address(0),"Exchange Already Exists!");

        Exchange exchange = new Exchange(_tokenAddress);

        // Saving the exchange address to the registry
        tokenToExchange[_tokenAddress] = address(exchange);
    }

    /// @notice This function will allows to query the registry to get back the Exchange
    /// @param _tokenAddress Pass the tokenAddress to get corrosponding the Exchange address

    function getExchange(address _tokenAddress) public returns(address) {
        return tokenToExchange[_tokenAddress];
    }

    

}