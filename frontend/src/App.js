import * as link from "./links.js";
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import "./App.css";
import { useAccount,WagmiConfig } from 'wagmi'
import {
  EthereumClient,
  modalConnectors,
  walletConnectProvider,
} from "@web3modal/ethereum";
import { Web3Modal } from "@web3modal/react";
import { configureChains, createClient } from "wagmi";
//   import {  configureChains, createClient, WagmiConfig } from "wagmi";
import { mainnet,polygonMumbai} from 'wagmi/chains'

// const chains = [ chain.polygon, chain.optimism, chain.arbitrum];

// Wagmi client
const { chains, provider } = configureChains([polygonMumbai], [
  walletConnectProvider({ projectId: "80b4f7a51140d759cb3f5da9dbe09b51" }),
]);
const wagmiClient = createClient({
  autoConnect: true,
  connectors: modalConnectors({ appName: "web3Modal", chains }),
  provider,
});

// Web3Modal Ethereum Client
const ethereumClient = new EthereumClient(wagmiClient, chains);
function App() {

  return (
    <>
      <WagmiConfig client={wagmiClient}>

        <Router>
          <Routes>
            <Route exact path='/' element={link.first()}></Route>
            <Route exact path='/form' element={link.form()}></Route>
            <Route exact path='/test' element={link.test()}></Route>
            <Route exact path='/proo' element={link.dis()}></Route>
            <Route exact path='/form2' element={link.form2()}></Route>
          </Routes>
        </Router>
      </WagmiConfig>
      <Web3Modal
        projectId="80b4f7a51140d759cb3f5da9dbe09b51"
        ethereumClient={ethereumClient}
      />
    </>
  );
}

export default App;
