#=
standalone: Settings for a standalone REPL
- Julia version: 1.0
- Author: singularitti
- Date: 2019-07-18
=#
function Base.parse(::Type{Rational}, x::String)
    list = split(x, '/'; keepempty = false)
    if length(list) == 1
        parse(Int, list[1]) // 1
    else
        @assert length(list) == 2
        parse(Int, list[1]) // parse(Int, list[2])
    end
end

function _parsenumber(v::String)
    occursin("/", v) && return parse(Rational, v)
    try
        parse(Int, v)
    catch ArgumentError
        parse(Float64, v)
    end
end

macro i_str(v)
    1 / _parsenumber(v)
end

macro sq_str(v)
    _parsenumber(v)^2
end

macro sqr_str(v)
    sqrt(_parsenumber(v))
end

macro isqr_str(v)
    1 / sqrt(_parsenumber(v))
end
