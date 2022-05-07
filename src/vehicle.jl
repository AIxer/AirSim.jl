abstract type Vehicle end

connect(::Type{T}, port::Integer) where T <: Vehicle = T(RPCSession(port))
connect(::Type{T}, addr::IPAddr, port::Integer) where T <: Vehicle = T(RPCSession(addr, port))

shutdown(v::Vehicle) = close(v.session)

# common APIs
reset(v::Vehicle) = call(v.session, :reset)
ping(v::Vehicle) = call(v.session, :ping)
serverversion(v::Vehicle) = call(v.session, :getServerVersion)

# basic flight control
function api_enable(v::Vehicle, enable, vname="")
    call(v.session, :enableApiControl, enable, vname)
end

api_enabled(v::Vehicle, vname="") = call(v.session, :isApiControlEnabled, vname)
disarm(v::Vehicle, arm, vname="") = call(v.session, :armDisarm, arm, vname)
sim_pause(v::Vehicle, pause) = call(v.session, :simPause, pause)
sim_paused(v::Vehicle) = call(v.session, :simIsPaused)
sim_nseconds(v::Vehicle, secds) = call(v.session, :simContinueForTime, secds)
sim_nframes(v::Vehicle, fs) = call(v.session, :simContinueForFrames, fs)
connected(v::Vehicle) = ping(v)