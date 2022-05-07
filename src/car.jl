struct Car <: Vehicle
    session::RPCSession
end

Car(port::Integer) = Car(RPCSession(port))

state(car::Car, vname="") = call(car.session, :getCarState, vname)
