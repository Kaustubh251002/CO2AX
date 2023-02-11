import React from 'react'
import Typewriter from 'typewriter-effect'
import Navbar from './Navbar'
import Link from 'next/link'

const HomePage
    = () => {
        return (
            <div>
                <div className='lines'>
                    <div className="line"></div>
                    <div className="line"></div>
                    <div className="line"></div>
                    <div className="line"></div>
                    <div className="line"></div>
                </div>
                <Navbar />
                <div className="relative h-screen justify-center gap-5">
                    <h1 className="mt-4 text-center text-8xl text-white font-mont tracking-medium font-semibold">CO-2-AX</h1>
                    <h2 className="mt-4 text-center text-2xl text-white font-mont mb-5">
                        <Typewriter
                            options={{
                                strings: ["Help Everyone by going Green!", "Reduce Greenhouse Gases!", "Taxation made easy through Blockchain!"],
                                autoStart: true,
                                loop: true,
                                delay: 75
                            }}
                        />
                    </h2>
                    <Link href="/Registration" className="w-max p-3 font-mont hover:scale-110 hover:border-2 hover:border-white text-white rounded transition duration-300 flex text-center gap-[10px] bg-[#1b222b] hover:bg-[#191e25]">Register Company</Link>
                    <h2 className='mt-7 text-center text-xl text-white font-mont'>About</h2>
                    <p className='text-center text-white text-l font-mono font-light'>CO2AX is a decentralized platform that is aimed at addressing the issue of greenhouse gas emissions by major companies in different sectors. The platform operates on the principle of tracking the emissions produced by these companies and taxing them based on a pre-determined threshold. The idea behind this concept is to incentivize companies to reduce their carbon footprint and contribute towards a greener and more sustainable future.</p>
                </div>
            </div>
        )
    }

export default HomePage
