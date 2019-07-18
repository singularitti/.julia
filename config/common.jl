#=
common.jl:
- Julia version: 1.0
- Author: qz
- Date: Jul 9, 2019
=#
using AbstractTrees

AbstractTrees.children(x::Type) = subtypes(x)

function showall(io, x, limit = true)
    println(io, summary(x), ":")
    Base.print_matrix(IOContext(io, :limit => limit), x)
end

Base.://(x, f::Function) = x |> f
