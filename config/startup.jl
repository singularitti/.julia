# Set up environment for Julia OSX binary distribution
let
    ROOT = abspath(Sys.BINDIR, "..")
    ENV["PATH"] = "$(Sys.BINDIR):$(ENV["PATH"])"
    ENV["TK_LIBRARY"] = "/System/Library/Frameworks/Tk.framework/Versions/8.5/Resources/Scripts"
    ENV["JULIA_EDITOR"] = "code"
    ENV["MPLBACKEND"] = "MacOSX"
end

if isfile("Project.toml")
    using Revise
    using BenchmarkTools
    using OhMyREPL
    colorscheme!("Base16MaterialDarker")
    enable_autocomplete_brackets(false)
    using Test
    using Pkg
    Pkg.activate(".")
else
    using LinearAlgebra
    using Dates
    →(args, f) = f(args...)  # From https://discourse.julialang.org/t/how-to-pass-multiple-arguments-to-a-function-using/29117/3
end

import AbstractTrees: children, print_tree
children(x::Type) = subtypes(x)
const pt = print_tree

using Unitful, UnitfulAtomic

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
