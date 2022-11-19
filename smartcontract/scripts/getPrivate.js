const ethers = require('ethers');

let mnemonic = process.argv.slice(2).join(" ");
let mnemonicWallet = ethers.Wallet.fromMnemonic(mnemonic);
console.log(`mnemonic: ${mnemonic}`);
console.log(`address: ${mnemonicWallet.address}`);
console.log(`privateKey: ${mnemonicWallet.privateKey}`);