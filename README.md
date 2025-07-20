# ERC20 Token

## What are ERC20 Tokens? 
ERC stands for **Ethereum Request for Comments**. An ERC20 Token is a type of token that follows a standardized set of rules and functions on the Ethereum blockchain. This standard ensures that all ERC20 tokens behave consistently and can interact seamlessly with wallets, exchanges, and other smart contracts.

ERC20 tokens enable essential functions like transfer, approve, mint, and burn operations. Popular examples of ERC20 tokens include DAI, USDC, WBTC, USDT, LINK, and UNI.

## ERC20 Standard Functions

The ERC20 standard defines the following required functions and events:

### Core Functions
- **`totalSupply()`** - Returns the total token supply
- **`balanceOf(address)`** - Returns the balance of a specific address  
- **`transfer(address, uint256)`** - Transfers tokens to another address
- **`transferFrom(address, address, uint256)`** - Transfers tokens on behalf of another address
- **`approve(address, uint256)`** - Approves another address to spend tokens
- **`allowance(address, address)`** - Returns the remaining approved amount

### Required Events
- **`Transfer(address indexed from, address indexed to, uint256 value)`**
- **`Approval(address indexed owner, address indexed spender, uint256 value)`**

## Common ERC20 Use Cases

- **Stablecoins** (USDC, DAI) - Digital dollars pegged to USD
- **Governance Tokens** (UNI, COMP) - Voting rights in protocols  
- **Utility Tokens** (LINK, BAT) - Access to specific services
- **Wrapped Assets** (WBTC, WETH) - Tokenized versions of other assets
- **Reward Tokens** - Incentive mechanisms in DeFi protocols

## This Implementation

This contract implements a simplified version of the ERC20 standard with the following features:

### Available Functions
- **`balanceOf(address)`** - View any address's token balance
- **`transfer(address, uint256)`** - Transfer tokens between addresses with built-in balance verification

### Key Features
- **Balance Tracking**: Uses `s_balances` mapping to track token ownership
- **Transfer Verification**: Includes a require statement to ensure total balance conservation during transfers
- **Underflow Protection**: Automatically reverts on insufficient balance attempts
- **Gas Efficient**: Minimal implementation focusing on core functionality

### Security Features
- **Arithmetic Safety**: Uses Solidity 0.8+ built-in overflow/underflow protection
- **Balance Conservation**: Verifies that total balances remain constant during transfers
- **Access Control**: Only token holders can transfer their own tokens (via `msg.sender`)

## Usage Examples

### Checking Balance
```solidity
uint256 balance = manualToken.balanceOf(userAddress);
```

### Transferring Tokens
```solidity
// Transfer 100 tokens to another address
ourToken.transfer(recipientAddress, 100 * 10e18);
```

## Testing

The contract includes comprehensive tests covering:
- Basic transfer functionality
- Balance verification
- Edge cases (zero transfers, self-transfers)

## Deployment

1. Deploy the contract to your preferred network
2. Set initial balances (if needed via constructor or mint function)
3. Users can then transfer tokens using the `transfer` function

## Important Notes

- This is a **minimal implementation** for learning purposes
- Missing some standard ERC20 functions like `approve`, `transferFrom`, and events
- No built-in minting mechanism (balances must be set via storage or constructor)
- Always test thoroughly before deploying to mainnet

## Follow Me On Twitter
![X (formerly Twitter) Follow](https://img.shields.io/twitter/follow/mibunna)
