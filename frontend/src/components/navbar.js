import "../css/navbar.css"
// import {name} from"../connection.js";
import { Web3Button } from "@web3modal/react";
// import { useAccount, useNetwork} from 'wagmi';


export default function Navbar() {
  // const { address} = useAccount();
  // const { chain } = useNetwork()
  return (
    <>
      <div className="nav-flex" id="section1">
        <a href="/">
          <button style={{ fontStyle: "italic", fontSize: "1ms" }}>CO2AX</button>
        </a>
        <a href="https://github.com/Kaustubh251002/CO2AX" target="_blank" rel="noreferrer">
          <button >
            Github
          </button>
        </a>
        <a href="https://twitter.com/CryptoSkool3" target="_blank" rel="noreferrer">
          <button >
            Twitter
          </button>
        </a>
        {/* <button style={{flex:"0 200px"}} id="connect" onClick={name}>Connect wallet</button> */}
        {/* {address && <ul >Network:{chain.name}</ul>} */}
        <Web3Button />
      </div>

    </>
  )
}
