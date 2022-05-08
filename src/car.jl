abstract type Car <: Vehicle end

mutable struct CarKinematics
    linear_acceleration::NED
    linear_velocity::NED
    orientation::NED
    position::NED
    angular_acceleration::NED
    angular_velocity::NED
end

mutable struct CarState
    speed::Float64
    handbrake::Bool
    maxrpm::Int
    rpm::Int
    kinematics_estimated::CarKinematics
    timestamp::Integer
    gear::Integer
end


function state(car::RPCSession{Car})
    info = call(car, :getCarState, car.name)
    dict2struct(CarState, info)
end