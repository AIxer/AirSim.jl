connect(::Type{T}, port::Integer=41451) where T <: RPCSession = RPCSession(T; port)
connect(::Type{T}, addr::IPAddr, port::Integer=41451) where T <: RPCSession = RPCSession(T; addr, port)

shutdown(s::RPCSession) = close(s)

# common APIs
reset(s::RPCSession) = call(s, :reset)
ping(s::RPCSession) = call(s, :ping)
serverversion(s::RPCSession) = call(s, :getServerVersion)

# basic flight control
api_enable(s::RPCSession, enable) = call(s, :enableApiControl, enable, s.name)
api_enabled(s::RPCSession) = call(s, :isApiControlEnabled, s.name)
disarm(s::RPCSession, arm) = call(s, :armDisarm, arm, s.name)
sim_pause(s::RPCSession, pause) = call(s, :simPause, pause)
sim_paused(s::RPCSession) = call(s, :simIsPaused)
sim_nseconds(s::RPCSession, secds) = call(s, :simContinueForTime, secds)
sim_nframes(s::RPCSession, fs) = call(s, :simContinueForFrames, fs)
connected(s::RPCSession) = ping(s)
homegeopoint(s::RPCSession) = call(s, :getHomeGeoPoint, s.name) |> GeoPoint
set_light_intensity(s::RPCSession, lightname, intensity) = call(s, :simSetLightIntensity, lightname, intensity)
function swaptextures(s::RPCSession, tags, tex_id=0, component_id=0, material_id=0)
    call(s, :simSwapTextures, tags, tex_id, component_id, material_id)
end

function set_object_material(s::RPCSession, object_name, material_name, component_id = 0)
    call(s, :simSetObjectMaterial, object_name, material_name, component_id)
end

function set_time_of_day(s::RPCSession, is_enabled, 
    start_datetime = "", is_start_datetime_dst = false, 
    celestial_clock_speed = 1, update_interval_secs = 60, 
    move_sun = true)
    call(s, :setTimeOfDay, is_enabled, start_datetime, is_start_datetime_dst, celestial_clock_speed, update_interval_secs, move_sun)
end

enable_weather(s::RPCSession, enable) = call(s, :enableWeather, enable)

set_weather_parameter(s::RPCSession, param, val) = call(s, :simSetWeatherParameter, param, val)

getimage(s::RPCSession, camera_name, image_type, external=false) =
    call(s, :simGetImage, camera_name, image_type, s.name, external)

getimages(s::RPCSession, requests, external=false) = 
    call(s, :simGetImages, requests, s.name, external) .|> ImageResponse