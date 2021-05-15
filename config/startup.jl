# Set up environment for Julia OSX binary distribution
let
    ROOT = abspath(Sys.BINDIR, "..")
    ENV["PATH"] = "$(Sys.BINDIR):$(ENV["PATH"])"
    ENV["TK_LIBRARY"] = "/System/Library/Frameworks/Tk.framework/Versions/8.5/Resources/Scripts"
    ENV["JULIA_EDITOR"] = "code"
    ENV["MPLBACKEND"] = "MacOSX"
end

import Pkg

if isfile("Project.toml")
    Pkg.activate(".")
    try
        using Revise
    catch e
        @warn "Error initializing Revise" exception = (e, catch_backtrace())
    end
    try
        using BenchmarkTools
    catch
    end
    try
        using OhMyREPL
        colorscheme!("Base16MaterialDarker")
        enable_autocomplete_brackets(false)
    catch
    end
else
    using LinearAlgebra
    using Dates
    →(args, f) = f(args...)  # From https://discourse.julialang.org/t/how-to-pass-multiple-arguments-to-a-function-using/29117/3
end

try
    import AbstractTrees
catch
end
AbstractTrees.children(x::Type) = subtypes(x)
using AbstractTrees: print_tree
const pt = print_tree

try
    using Unitful, UnitfulAtomic
catch
end

# See https://mmus.me/blog/importall/
macro importall(mod)
    quote
        try
            $(esc(mod))
        catch
            import $(mod)
        end
        for name in names($(esc(mod)), all=true)
            if name ∉ (:eval, :include, :__init__)
                @eval import .$(mod): $(Expr(:$, :name))
            end
        end
    end
end
