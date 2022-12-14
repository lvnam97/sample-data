# Sample Data

# Sample Contract
## Install
```
    cd smartcontract
    npm i
```
## Config with your wallet address
1. Get Private Key From Seed Phrase
    * Run command: ```npm run getPrivate {seed_phrase}```
    * Ex: ```npm run getPrivate hehe haha gift glide once chunk menu dad slow payment huhu hihi```
2. Edit hardhat.config.js file with your private key
## Useage
### Chain name
* dev
* avaxtest
* bsctest

### Compile *.sol files
```
    npx hardhat compile
```
### Deploy 721, 1155
**Command**
* ```npm run deploy721-{chain_name} {number_of_contracts}```
* ```npm run deploy1155-{chain_name} {number_of_contracts}```

**Example**
* Chain dev:
    ```npm run deploy721-dev 5```
* Chain avaxtest:
    ```npm run deploy721-avaxtest 5```
* Chain bsctest:
    ```npm run deploy721-bsctest 5```

### Mint 721, 1155
**Command** 
* ```npm run mint721-{chain_name} {contract_address} {number_of_nfts} [{forAddress}]```
* ```npm run mint1155-{chain_name} {contract_address} {number_of_nfts} [{forAddress}]```

**Example**
* Chain dev: 
    ```npm run mint721-dev 0xE7cEdcbAB4BAe413B5C7c2BF09da9B7e7dd27775 5 0x0676a8136eC8C25918eA04D15Ed3c8e7E4DE9f46```
* Chain avaxtest:
        ```npm run mint721-avaxtest 0xF3d43c147a0A377B4Eae8A44B778b575C1b59d72 5 0x0676a8136eC8C25918eA04D15Ed3c8e7E4DE9f46```
* Chain bsctest:
    ```npm run mint721-bsctest 0x6f822246D4351e05e7fAb3eAccE7256965BE9780 5 0x0676a8136eC8C25918eA04D15Ed3c8e7E4DE9f46```

### Mint Batch 721, 1155
**Command** 
* ```npm run mintBatch721-{chain_name} {contract_address} {nfts_each_loop} {number_of_loops} {forAddress}```
* ```npm run mintBatch1155-{chain_name} {contract_address} {nfts_each_loop} {number_of_loops} {forAddress}```

**Example**
* 721:
    ```npm run mintBatch721-dev 0xF00E12257eF5bE878c91094632E653Fe8713dA63 100 2 0x221A2E8b49A27404635016d7c83EBE6F40EFAf4F```
* 1155:
    ```npm run mintBatch1155-dev 0xD4466b1370c7B13E5c11502071b84F0c8aC2bfbb 100 3 0x221A2E8b49A27404635016d7c83EBE6F40EFAf4F```

### Deploy, mint ERC20
**Command**
* Deploy ```npm run deploy20-{chain_name} {number_of_contracts}```
* Mint ```npm run mint20-{chain_name} {contract_address} {amount} [forAddress]```

**Example**
* Deploy ```npm run deploy20-dev 2```
* Mint ```npm run mint20-dev 0x7511A85F312Ca2DC0EFA725B46d7D26c083b414f 123```