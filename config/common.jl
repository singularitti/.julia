#=
common: Settings loaded both by a project or a standalone REPL
- Julia version: 1.0
- Author: singularitti
- Date: 2019-07-18
=#
using LinearAlgebra

try
    import Pkg
    haskey(Pkg.installed(), "Revise") || @eval Pkg.add("Revise")
    haskey(Pkg.installed(), "AbstractTrees") || @eval Pkg.add("AbstractTrees")
catch
end

import AbstractTrees
AbstractTrees.children(x::Type) = subtypes(x)
using AbstractTrees: print_tree

# From https://discourse.julialang.org/t/how-to-pass-multiple-arguments-to-a-function-using/29117/3
→(args, f) = f(args...)
