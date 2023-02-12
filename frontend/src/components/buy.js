import { useState } from "react";
import "../css/buy.css";
import { LoadComp,Investtkn } from "./test";
export default function Buy(s) {
    const onChange = e => {
        setName(e.target.value)
    }
    const [name, setName] = useState(null);
    return (
        <>
            <div className="grid-buy">
                <div className="grid-buy-container">
                    <div style={{ fontSize: "xx-large", textAlign: "center" }}>
                        <LoadComp param={"name"} />
                    </div>
                    <div className="buy-grid-inside">

                        <img src={s.id} alt="BigCo Inc. logo" />

                        {/* <div className="grid-inside-buy-container"> */}
                        {/* </div> */}
                        <div className="grid-inside-buy-container">
                            <LoadComp param={"name"} />
                            <br />
                            <LoadComp param={"symbol"} />
                            <br />
                            Amount= <LoadComp param={"totalSupply"} /> remaining
                            <br />
                            <form>
                                <input min="0" max="10" inputMode="numeric" onChange={onChange} type="number" placeholder="How much u want to invest" style={{ width: "10vw" }} />
                            </form>
                            <div style={{ fontSize: "medium" }}>
                                Investing - {name} Eth
                            </div>
                            <Investtkn param={name}/>
                        </div>
                    </div>
                    ** Currently Site is in development stage, This option not available**
                </div>
            </div>
        </>
    )
}