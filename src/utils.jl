dict2struct(::Type{T}, x) where T = convert(T, x)
function dict2struct(::Type{T}, dict::Dict) where T
    args = map(fieldnames(T)) do n
        dict2struct(fieldtype(T, n), dict[String(n)])
    end
    T(args...)
end