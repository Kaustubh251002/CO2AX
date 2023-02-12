import { useState } from "react"
import { Modal } from "@mantine/core";
import Buy from "./buy"
import "../css/content.css";
import { useAccount } from 'wagmi';
const Card = (s) => {
    function allert() {
        alert("Please connect your wallet to proceed!!!");
    }
    const { address } = useAccount();
    const [opened, setOpened] = useState(false);
        return (
            <>
                <Modal
                    opened={opened}
                    onClose={() => setOpened(false)}
                    withCloseButton={true}
                    styles={{ modal: { backgroundColor: "rgba(0,0,0,0.8)" } }}
                    centered
                    fullScreen
                    padding={0}
                >
                    <Buy {...s} />

                </Modal>
                <div className="grid-C-content">
                    <img src={s.id} alt="logo" />
                    <br />
                    <div >
                        {s.name}
                        <br />
                        {s.disc}
                        <br />
                        {s.price}
                        <br />
                        {s.symbol}
                        <br />
                        {/* <button id="invest_btn" onClick={name()} >Know More</button> */}
                        {address?(
                            <button id="invest_btn" onClick={() => setOpened(true)} >Know More</button>
                            ):(
                                <button id="invest_btn" onClick={allert} title="Connect wallet to Invest">Know More</button>
                                
                        )
                    }
                    </div>

                </div>
            </>

        )
}

export default Card;