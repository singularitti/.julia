#!/usr/bin/env julia
ENV["JULIA_NUM_THREADS"] = 16
ENV["JULIA_EDITOR"] = "code"
ENV["PYTHON"] = "python"

atreplinit() do repl
    if isfile("Project.toml")
        try
            @eval using Revise
            @async Revise.wait_steal_repl_backend()
        catch
            try
                @eval using Pkg
                haskey(Pkg.installed(), "Revise") || @eval Pkg.add("Revise")
            catch
            end
        end
    end
end

try
    import AbstractTrees
    AbstractTrees.children(x::Type) = subtypes(x)
    using AbstractTrees: print_tree
catch
    try
        using Pkg
        haskey(Pkg.installed(), "AbstractTrees") || @eval Pkg.add("AbstractTrees")
    catch
    end
end

if isfile("Project.toml")
    using Pkg
    Pkg.activate(".")
else
    using LinearAlgebra
    # From https://discourse.julialang.org/t/how-to-pass-multiple-arguments-to-a-function-using/29117/3
    →(args, f) = f(args...)
    Base.round(x::AbstractMatrix, digits::Int = 15) = round.(x, digits = digits)
    LinearAlgebra.dot(x, A, y) = dot(x, A*y)
end
