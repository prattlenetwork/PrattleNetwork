/*
 * NB: since truffle-hdwallet-provider 0.0.5 you must wrap HDWallet providers in a 
 * function when declaring them. Failure to do so will cause commands to hang. ex:
 * ```
 * mainnet: {
 *     provider: function() { 
 *       return new HDWalletProvider(mnemonic, 'https://mainnet.infura.io/<infura-key>') 
 *     },
 *     network_id: '1',
 *     gas: 4500000,
 *     gasPrice: 10000000000,
 *   },
 */

const {readFileSync} = require('fs');
const LoomTruffleProvider = require('loom-truffle-provider');

const chainId = 'default';
//const writeUrl   = 'http://127.0.0.1:46658/rpc';
//const readUrl    = 'http://127.0.0.1:46658/query';
const writeUrl = 'http://207.180.230.5:46658/rpc';
const readUrl = 'http://207.180.230.5:46658/query';
const privateKey = readFileSync('./priv_key', 'utf-8');

const loomTruffleProvider = new LoomTruffleProvider(chainId, writeUrl, readUrl, privateKey);

const loomProvider = loomTruffleProvider.getProviderEngine();
loomTruffleProvider.createExtraAccounts(10);


console.log("Accounts list", loomProvider.accountsAddrList);
console.log("Accounts and Private Keys", loomProvider.accounts);

module.exports = {
    networks: {
        loom_dapp_chain: {
            provider: loomTruffleProvider,
            network_id: '*'
        }
    }
};

