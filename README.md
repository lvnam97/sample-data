# Sample Data

# Sample Contract
## Install
```
    cd smartcontract
    npm i
```
## Useage
### Chain name
    * dev
    * avaxtest
    * bsctest

### Deploy 721, 1155
Command: ```
        npm run deploy721-{chain_name} {number_of_contracts}
        npm run deploy1155-{chain_name} {number_of_contracts}
    ```
**Example**
* Chain dev: ```
        npm run deploy721-dev 5
    ```
* Chain avaxtest: ```
        npm run deploy721-avaxtest 5
    ```
* Chain bsctest: ```
        npm run deploy721-bsctest 5
    ```

### Mint 721, 1155
Command: ```
        npm run mint721-{chain_name} {contract_address} {number_of_nfts}
    ```
**Example**
* Chain dev: ```
        npm run mint721-dev 0xE7cEdcbAB4BAe413B5C7c2BF09da9B7e7dd27775 5
    ```
* Chain avaxtest: ```
        npm run mint721-avaxtest 0xF3d43c147a0A377B4Eae8A44B778b575C1b59d72 5
    ```
* Chain bsctest: ```
        npm run mint721-bsctest 0x6f822246D4351e05e7fAb3eAccE7256965BE9780 5
    ```