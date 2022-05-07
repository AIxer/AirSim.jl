struct Drone <: Vehicle
    session::RPCSession
end

multirotor(drone::Drone, vname="") = call(drone.session, :getMultirotorState, vname)