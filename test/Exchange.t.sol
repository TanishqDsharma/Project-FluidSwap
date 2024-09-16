// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Test,console} from "../lib/forge-std/src/Test.sol";
import {Exchange} from "../src/Exchange.sol";
import {ERC20Token} from "../src/ERC20Token.sol";

contract TestExchange is Test{

ERC20Token token;
Exchange exchange;
address user = makeAddr("USER");

    function setUp() external{
        vm.prank(user);
        token = new ERC20Token("Zswap","ZS",10000 ether);
        vm.deal(user,10000 ether);
        exchange = new Exchange(address(token));
    }



    
    function testAddLiquidity() public {
        vm.startPrank(user);
        
        // Allowing exchange contract to spend tokens on our behalf
        token.approve(address(exchange), type(uint256).max);
        // Calling AddLiquidity to deposit 50 ether worth of tokens and 25 ether worth of eth 
        exchange.addLiquidity{value:25 ether}(50 ether);
        // Confirming the contract has the 50 ether worth of tokens 
        assert(exchange.getReserve()==50 ether);
        // Confirming the contract has the 25 ether worth of eth tokens 
        assert(address(exchange).balance==25 ether);
        vm.stopPrank();

    }

    function testPriceCalculation() public {
        vm.startPrank(user);
        token.approve(address(exchange),2000 ether);
        exchange.addLiquidity{value:1000 ether}(2000 ether);
        assert(exchange.getPrice(1000 ether,2000 ether)==500);
        assert(exchange.getPrice(2000 ether,1000 ether)== 2000);
        vm.stopPrank();
    }

    function testAmountCalculation() public{
        vm.startPrank(user);
        token.approve(address(exchange),2000 ether);
        exchange.addLiquidity{value:1000 ether}(2000 ether);
        vm.stopPrank();

        console.log("Eth we are getting for selling 1 ether worth of tokens: ",exchange.getEthAmount(2 ether));
        console.log("Token we are getting for selling 1 eth",exchange.getTokenAmount(1 ether));
    }
}