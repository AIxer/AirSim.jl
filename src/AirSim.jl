module AirSim

using Sockets
using MsgPack

export RPCSession, call
export Car, Drone, ping, sim_paused, sim_pause, shutdown,
    state, multirotor


abstract type Vehicle end

include("datatypes.jl")
include("utils.jl")
include("rpc.jl")
include("common.jl")
include("car.jl")
include("drone.jl")

end # module
