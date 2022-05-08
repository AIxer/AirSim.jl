abstract type AirSimDataType end
abstract type ImageType <: AirSimDataType end


struct Scene <: ImageType end
struct DepthPlanar <: ImageType end
struct DepthPerspective <: ImageType end
struct DepthVis <: ImageType end
struct DisparityNormalized <: ImageType end
struct Segmentation <: ImageType end
struct SurfaceNormals <: ImageType end
struct Infrared <: ImageType end
struct OpticalFlow <: ImageType end
struct OpticalFlowVis <: ImageType end

MsgPack.msgpack_type(::Type{<:AirSimDataType}) = MsgPack.StructType()

struct NED <: AirSimDataType
    x_val::Float64
    y_val::Float64
    z_val::Float64
end
NED(d::Dict) = dict2struct(NED, d)

struct GeoPoint <: AirSimDataType
    latitude::Float64
    longitude::Float64
    altitude::Float64
end
GeoPoint(d::Dict) = dict2struct(GeoPoint, d)

struct YawMode <: AirSimDataType
    israte::Bool
    yaw_or_rate::Float64
end

struct Quaternionr <: AirSimDataType
    w_val::Float64
    x_val::Float64
    y_val::Float64
    z_val::Float64
end


struct ImageResponse <: AirSimDataType
    image_data_uint8::UInt8
    iamge_data_float::Float64
    camera_position::NED
    camera_orientation::Quaternionr
    tiem_stamp::UInt64
    message::AbstractString
    pixels_as_float::Float64
    compress::Bool
    width::Float64
    height::Float64
    image_type::ImageType
end

