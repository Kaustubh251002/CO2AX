import React from 'react'
import Link from 'next/link'
import { WagmiConfig, createClient, configureChains } from 'wagmi'
import {
    EthereumClient,
    modalConnectors,
    walletConnectProvider,
} from "@web3modal/ethereum";
import { Web3Modal } from "@web3modal/react"
import { mainnet, polygonMumbai, bsc } from 'wagmi/chains'
import { Web3Button } from '@web3modal/react'


const { chains, provider } = configureChains([mainnet, polygonMumbai, bsc], [
    walletConnectProvider({ projectId: "80b4f7a51140d759cb3f5da9dbe09b51" }),
]);
const wagmiClient = createClient({
    autoConnect: true,
    connectors: modalConnectors({ appName: "web3Modal", chains }),
    provider,
});

// Web3Modal Ethereum Client
const ethereumClient = new EthereumClient(wagmiClient, chains);

const Navbar = () => {
    return (
        <nav>
            <div className="flex flex-wrap items-center justify-between w-full py-4 md:py-0 px-4 text-lg text-gray-700 bg-black">
                <Web3Modal
                    projectId="80b4f7a51140d759cb3f5da9dbe09b51"
                    ethereumClient={ethereumClient}
                />
                <div className="pt-2 pb-2">
                    <Link href="/" className='fixed top-0 left-0 w-[50px] h-[50px]'><img src='/logo.png'/></Link>
                    <Web3Button />
                </div>
            </div>
        </nav>
    )
}

export default Navbar
