# Project-ZSwap

**Description:** This project will focus on building clone of Uniswap V1. Uniswap is a decentralized exchange that aims to be an alternative for CEX.



## Constant Product Market Maker

Automated Market Maker is a general term that embraces different decentralized market maker algos. A constant product market maker is a type of AMM commonly used in DEXs such as uniswap. It operates based on mathematical formula to determine the price of assets in a liquidity pool without relying on an order book.


The formula uniswap works on is: xy=k

Where:
- x: is ether reserve
- y: is token reserve 
- k: is a contanst

NOTE: Uniswap requires that k remains same no matter how much of reservers x or y are.


### Token Contract:
Since Uniswap v1 supports ether-token swaps. For that we need to create a ERC20 token contract.

### Exchange Contract:

**Uniswap V1 has only two contracts: Factory and Exchange**

* Factory contract is a registry contract that allows to create exchanges and keeps track of all deployed exchanges, allowing to  find exchange address with token address and vice-versa.
* Whereas, Exchange Contract actually defines exchanging logic. Each pair (eth-token) is deployed as an excahnge contract and allows to exchange ether to/from only one token.
