// import ethers.js
const ethers = require('ethers')

async function run() {
    let network = 'http://localhost:8545'
    let provider = ethers.getDefaultProvider(network)
    let privateKey = '0x53f2475c8091282cadc01a419e75bb834751810cc2ef472b12a3a67d2d3eb311'
    let wallet = new ethers.Wallet(privateKey, provider)
    let receiverAddress = '0xF02c1c8e6114b1Dbe8937a39260b5b0a374432bB'
    let amountInEther = '0.01'
    let tx = {
        to: receiverAddress,
        value: ethers.utils.parseEther(amountInEther)
    }

    const balance = await wallet.getBalance()
    console.log("Balance ", balance.toString())

    // Send a transaction
    const txResult = await wallet.sendTransaction(tx)
    console.log("tx result", txResult)
    
}


run()