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

mutable struct CarControl
    brake::Float64
    is_manual_gear::Bool
    handbrake::Bool
    manual_gear::Int
    steering::Float64
    throttle::Float64
    gear_immediate::Bool
end

MsgPack.msgpack_type(::Type{CarControl}) = MsgPack.StructType()

function state(car::RPCSession{Car})
    call(car, :getCarState, car.name)
end

function controls(car::RPCSession{Car})
    info = call(car, :getCarControls, car.name)
    dict2struct(CarControl, info)
end

function setcontrols(car::RPCSession{Car}, controls)
    call(car, :setCarControls, controls, car.name)
end