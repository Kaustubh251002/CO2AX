import Head from 'next/head'
import Image from 'next/image'
import { Inter } from '@next/font/google'
import styles from '@/styles/Home.module.css'
import Typewriter from 'typewriter-effect'
import Link from 'next/link'
import { WagmiConfig,createClient,configureChains,mainnet } from 'wagmi'
import { getDefaultProvider } from 'ethers'
import WagmiProfile from '@/components/WagmiProfile'
import { alchemyProvider } from 'wagmi/providers/alchemy'
import { publicProvider } from 'wagmi/providers/public'
import { CoinbaseWalletConnector } from 'wagmi/connectors/coinbaseWallet'
import { InjectedConnector } from 'wagmi/connectors/injected'
import { MetaMaskConnector } from 'wagmi/connectors/metaMask'
import { WalletConnectConnector } from 'wagmi/connectors/walletConnect'

const { chains, provider, webSocketProvider } = configureChains(
  [mainnet],
  [alchemyProvider({ apiKey: 'yourAlchemyApiKey' }), publicProvider()],
)
 
// Set up client
const client = createClient({
  autoConnect: true,
  connectors: [
    new MetaMaskConnector({ chains }),
    new CoinbaseWalletConnector({
      chains,
      options: {
        appName: 'wagmi',
      },
    }),
    new WalletConnectConnector({
      chains,
      options: {
        qrcode: true,
      },
    }),
    new InjectedConnector({
      chains,
      options: {
        name: 'Injected',
        shimDisconnect: true,
      },
    }),
  ],
  provider,
  webSocketProvider,
})

export default function Home() {
  return (
    <>
      <div className="wave"></div>
      <div className="wave"></div>
      <div className="wave"></div>
      <div className="relative h-screen flex justify-center flex-col gap-5">
        <h1 className="text-center text-8xl text-white mt-4 font-mono tracking-wide font-bold mb-5">CO-2-AX</h1>
        <h2 className="text-center text-3xl text-white font-mono mb-5">
          <Typewriter
            options={{
              strings: ["Help Everyone by going Green!", "Reduce Greenhouse Gases!", "Taxation made easy through Blockchain!"],
              autoStart: true,
              loop: true,
              delay: 75
            }}
          />
        </h2>
        <div className="items-center w-full flex flex-row justify-center gap-4">
          <Link href="/Registration" className="font-mono p-3 hover:scale-110 hover:border-2 hover:border-white  text-white rounded transition duration-300 flex text-center items-center gap-[10px] bg-gradient-to-r from-violet-500 to-cyan-500 ">
            <span>Register</span>
          </Link>
          <div>
            <WagmiConfig client={client}>
              <WagmiProfile />
            </WagmiConfig>
          </div>
        </div>
      </div>
    </>
  )
}
