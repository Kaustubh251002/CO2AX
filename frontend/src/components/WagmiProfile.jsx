import {
    useAccount,
    useConnect,
    useDisconnect,
    useEnsAvatar,
    useEnsName,
} from 'wagmi'
import { InjectedConnector } from 'wagmi/connectors/injected'

function WagmiProfile() {
    const { address, connector, isConnected } = useAccount()
    const { data: ensAvatar } = useEnsAvatar({ address })
    const { data: ensName } = useEnsName({ address })
    const { connect, connectors, error, isLoading, pendingConnector } =
        useConnect()
    const { disconnect } = useDisconnect()

    if (isConnected) {
        return (
            <div>
                <button className="font-mono p-3 hover:border-2 hover:border-white text-white rounded transition duration-300 flex  gap-[10px] bg-gradient-to-r  from-violet-500 to-cyan-500 text-center"
                    onClick={disconnect}>Disconnect</button>
                <div className='text-center text-xl text-white font-mono mb-2 fixed bottom-0 right-0'>
                    <div>{ensName ? `${ensName} (${address})` : address} Connected to {connector.name}</div>
                </div>
            </div>
        )
    }

    return (
        <>
            <div className='w-full flex flex-row justify-items-start gap-4'>
                {connectors.map((connector) => (
                    <button
                        disabled={!connector.ready}
                        key={connector.id}
                        onClick={() => connect({ connector })}
                        className="font-mono p-3 border-2  hover:border-2 hover:border-white text-white rounded transition duration-300 flex gap-[10px] bg-gradient-to-r  from-violet-500 to-cyan-500 text-center"
                    >
                        {connector.name}
                        {!connector.ready && ' (unsupported)'}
                        {isLoading &&
                            connector.id === pendingConnector?.id &&
                            ' (connecting)'}
                    </button>
                ))}
            </div>
            {
                error &&
                <div className='text-center text-xl text-white font-mono mb-2 fixed bottom-0 right-0'>
                    Wallet Connection Error:   {error.message}
                </div>
            }
        </>
    )
}

export default WagmiProfile