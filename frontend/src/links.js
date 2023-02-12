import Connect from "./components/form";
import Content from "./components/content";
import Footer from "./components/footer";
import Landing from "./components/landing";
import Navbar from "./components/navbar";
import Enter from "./components/enter";
import { LoadComp } from "./components/test";
import Caution from "./components/caution";
import Buy from "./components/buy";
import { MintNFT } from "./components/problem";
export const first = () => {
    return (<>
        <Navbar />
        <Landing/>
        <Content />
        <Enter />
        <Caution/>
    </>
    )
}
export const form = () => {
    return (<>
        <Navbar />
        <Connect />
        <Caution/>
    </>
    )
}
export const test=()=>{
    return(
        <LoadComp/>
    )
}
export const dis=()=>{
    return(
        <MintNFT/>
    )
}