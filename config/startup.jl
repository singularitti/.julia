# Set up environment for Julia OSX binary distribution
let
    ROOT = abspath(Sys.BINDIR, "..")
    ENV["PATH"] = "$(Sys.BINDIR):$(ENV["PATH"])"
    ENV["FONTCONFIG_PATH"] = joinpath(ROOT, "etc", "fonts")
    ENV["TK_LIBRARY"] = "/System/Library/Frameworks/Tk.framework/Versions/8.5/Resources/Scripts"
    ENV["JULIA_EDITOR"] = "code"
end

import Pkg

if isfile("Project.toml")
    Pkg.activate(".")
    try
        using Revise
    catch
        Pkg.add("Revise")
    end
else
    using LinearAlgebra
    →(args, f) = f(args...)  # From https://discourse.julialang.org/t/how-to-pass-multiple-arguments-to-a-function-using/29117/3
    Base.round(x::AbstractMatrix, digits::Int = 15) = round.(x, digits = digits)
end

try
    import AbstractTrees
    AbstractTrees.children(x::Type) = subtypes(x)
    using AbstractTrees: print_tree
catch
    Pkg.add("AbstractTrees")
end
