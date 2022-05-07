module AirSim

using Sockets
using MsgPack

export RPCSession, call
export Car, Drone, ping, sim_paused, sim_pause, shutdown,
    state, multirotor

include("rpc.jl")
include("vehicle.jl")
include("car.jl")
include("drone.jl")

end # module
