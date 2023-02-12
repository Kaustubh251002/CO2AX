import "../css/form.css";
import { useAccount } from 'wagmi';


export default function Connect2() {

    const { address } = useAccount();
    if (address) {
        return (
            <>
                <div className="connect">
                    <br /><br />
                    <div className="txt" style={{ fontSize: "3em" }}>
                        Enter Gas Emition Your Company
                    </div>
                    <form style={{ marginTop: "3vh" }}>
                        <h2>Company's Emition</h2>
                        {/* <label for="name">Company Name: </label>
                        <input type="text" id="name" name="name" /><br /> */}
                        <label for="CO2">CO2 equivalent emissions in metric tons:   </label>
                        <input type="text" id="CO2" name="CO2" /><br />
                        <label for="SO2">SO2 equivalent emissions in metric tons:   </label>
                        <input type="text" id="SO2" name="SO2" /><br />
                        <label for="CFC">CFC equivalent emissions in metric tons:   </label>
                        <input type="text" id="CFC" name="CFC" /><br />
                        {/* <label for="type">Choose type of Industry:  </label>
                        <select id="type" name="type">
                            <option value="Food">Food</option>
                            <option value="Manufacturing">Manufacturing</option>
                            <option value="Technology">Technology</option>
                            <option value="Agriculture">Agriculture</option>
                        </select><br /> */}

                        <input type="submit" />
                    </form>
                    <br />
                </div>
            </>
        )
    } else {
        return (
            <div className="connect">
                <div className="txt" style={{ fontSize: "3em" }}>
                    Please Connect to a Wallet to Proceed!!
                </div>
            </div>
        )
    }
}