# Set up environment for Julia OSX binary distribution
let
    ROOT = abspath(Sys.BINDIR, "..")
    ENV["PATH"] = "$(Sys.BINDIR):$(ENV["PATH"])"
    ENV["FONTCONFIG_PATH"] = joinpath(ROOT, "etc", "fonts")
    ENV["TK_LIBRARY"] = "/System/Library/Frameworks/Tk.framework/Versions/8.5/Resources/Scripts"
    ENV["JULIA_EDITOR"] = "code"
    ENV["MPLBACKEND"] = "MacOSX"
end

import Pkg

if isfile("Project.toml")
    Pkg.activate(".")
    try
        using Revise
    catch
        Pkg.add("Revise")
    end
    try
        using BenchmarkTools
    catch
        Pkg.add("BenchmarkTools")
    end
    try
        using OhMyREPL
        colorscheme!("Base16MaterialDarker")
        enable_autocomplete_brackets(false)
    catch
        Pkg.add("OhMyREPL")
    end
else
    using LinearAlgebra
    using Dates
    →(args, f) = f(args...)  # From https://discourse.julialang.org/t/how-to-pass-multiple-arguments-to-a-function-using/29117/3
end

try
    import AbstractTrees
catch
    Pkg.add("AbstractTrees")
end
AbstractTrees.children(x::Type) = subtypes(x)
using AbstractTrees: print_tree

try
    import ClearStacktrace
catch
    Pkg.add("ClearStacktrace")
end
ClearStacktrace.LINEBREAKS[] = false

try
    import ClearMethods
catch
end

try
    using Unitful, UnitfulAtomic
catch
    Pkg.add("Unitful")
    Pkg.add("UnitfulAtomic")
end
