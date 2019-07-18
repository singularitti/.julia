#=
filename: standalone.jl
- Julia version: 1.1
- Author: qz
- Date: May 10, 2019
=#
using LinearAlgebra

function Base.parse(::Type{Rational}, x::String)
    list = split(x, '/'; keepempty=false)
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

function subtypetree(t, level::Int = 1, indent::Int = 4)
    level == 1 && println(t)
    for s in subtypes(t)
        println(join(fill(" ", level * indent)) * string(s))
        subtypetree(s, level + 1, indent)
    end
end

Base.://(x, f::Function) = x |> f
