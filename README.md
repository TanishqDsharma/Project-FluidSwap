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


# Liquidity Providers: 

Liquidity providers are users who contribute funds to a pool, enabling token swaps or other transactions within a decentralized exchange. In return for providing liquidity, they receive rewards or incentives. Without such rewards, there would be little motivation for users to lock their assets in a contract, as they would gain nothing from doing so. Therefore, it's essential to implement a system that fairly compensates liquidity providers, ensuring they are incentivized to continue supporting the platform with their funds.

### How LPs are rewarded? 

The LPs, are rewarded with the fees that DEX generates for each token swap. This also seems pretty much fair: users (traders) pay for services (liquidity) provided by other people. To, ensure fair distribution, rewards are proportional to the amount of liquidity each LP contributes to the pool. For example, if an LP provides 50% of the pool’s liquidity, they will receive 50% of the accumulated fees.

### What are LP Tokens?

LP tokens are ERC20 tokens that are issued to liquidity Providers in exchange for their liquidity. LP tokesn are treated as shares:

1. LPs deposit liquidity into the pool and receive LP tokens as proof of their contribution.
2. The number of LP tokens issued is proportional to the share of liquidity the provider contributes to the pool's reserves.
3. This system ensures that fees are distributed fairly among LPs based on their share of the pool.
4. LP tokens can be redeemed at any time for the underlying liquidity plus any accumulated fees. 

#### How to Calculate LP Tokens When Adding Liquidity?

Here’s what we need to think about when giving out LP tokens to liquidity providers:

* Fairness: Your share in the pool should always be correct. Even if other people add or remove liquidity, the value of your share should not change unfairly.
* Write Operations: Another thing, we need to ensure that we cant keep on changing or storing new data on the Ethereum blockchain as transactions are very expensive on ethereum.
* Issuing of LP tokens:
    * If we gave out too many LP tokens (e.g., 1 billion) and kept splitting them among new providers, we’d have to keep recalculating who owns how much. This is slow and costly.
    * If we give out too few tokens, we could run out and then have to redistribute, which is also a problem.

So, the best solution is to have `No Fixed Supply`. Instead of giving out a set number of tokens, we will create (mint) new LP tokens every time someone adds liquidity. This way, the system can grow as much as it needs without running into token supply problems. This also helps to maintain the value of `LP tokens` because LP tokens are always tied to the real liquidity in the pool. So, as more tokens are created, the liquidity backing them also increases.


<H4>How to calculated the amount of minted LP-tokens when liquidity is deposited?</H4>

Below equation shows how the amount of new LP-tokens is calculated depending on the amount of ethers deposited:

amountMinted=totalAmount∗ethReserve/ethDeposited


# ​Fees

We will collect fees for every swap that happens on the DEX. Fees will be paid in the currency of the asset that being traded. Liquidity providers get a balanced amount of ethers and tokens plus a share of accumulated fees proportional to the share of their LP-tokens.

* Uniswap takes 0.3% in fees from each swap. For our project we will take 1% for seeing the differeneces in amount during testing.

####  What is  Factory Contract?
 
Factory contract serves as a registry of exchanges: Every new deployed contract is registered with a Factory.
* Any exchange can be found by querying th registry.By having such registry exchanges can find other exchanges when user tries to swap a token for another token (and not ether).


