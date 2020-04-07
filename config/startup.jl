#!/usr/bin/env julia
ENV["JULIA_EDITOR"] = "code"

function _addpkg(pkg)
    try
        @eval using Pkg
        Pkg.add(pkg)
    catch e
        @warn(e.msg)
    end
end # function _addpkg

atreplinit() do repl
    if isfile("Project.toml")
        try
            @eval using Revise
            @async Revise.wait_steal_repl_backend()
        catch
            _addpkg("Revise")
        end
        @eval using Pkg
        Pkg.activate(".")
    else
        @eval begin
            using LinearAlgebra
            # From https://discourse.julialang.org/t/how-to-pass-multiple-arguments-to-a-function-using/29117/3
            →(args, f) = f(args...)
            Base.round(x::AbstractMatrix, digits::Int = 15) = round.(x, digits = digits)
        end
    end
end

try
    import AbstractTrees
    AbstractTrees.children(x::Type) = subtypes(x)
    using AbstractTrees: print_tree
catch
    _addpkg("AbstractTrees")
end

try
    using ClearStacktrace
catch
    _addpkg("ClearStacktrace")
end
