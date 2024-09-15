// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.18;

import {Test,console} from "../lib/forge-std/src/Test.sol";
import {Exchange} from "../src/Exchange.sol";
import {ERC20Token} from "../src/ERC20Token.sol";

contract TestExchange is Test{

ERC20Token token;
Exchange exchange;
address user = makeAddr("USER");

    function setUp() external{
        vm.prank(user);
        token = new ERC20Token("Zswap","ZS",1000 ether);
        vm.deal(user,1000 ether);
        exchange = new Exchange(address(token));
    }



    
    function testAddLiquidity() public {
        vm.startPrank(user);
        
        //Allowing exchange contract to spend tokens on our behalf
        token.approve(address(exchange), type(uint256).max);

        exchange.addLiquidity{value:25 ether}(50 ether);
        assert(exchange.getReserve()==50 ether);
        assert(address(exchange).balance==25 ether);
        vm.stopPrank();

    }
}