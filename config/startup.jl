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
    # From https://github.com/singularitti/vscode-julia-formatter/issues/6#issuecomment-831003507
    using JuliaFormatter: format
    using FileWatching: watch_folder, unwatch_folder
    function watch_format(
        watched_dir::AbstractString,
        timeout_sec::Real = -1,
        debounce_time_sec::Real = 1,
    )
        while true
            file_changed, change_info = watch_folder(watched_dir, timeout_sec)
            if change_info.changed
                println(file_changed)
                format(watched_dir)
            end
            unwatch_folder(watched_dir)
            sleep(debounce_time_sec)
        end
    end
else
    using LinearAlgebra
    using Dates
end

→(args, f) = f(args...)  # From https://discourse.julialang.org/t/how-to-pass-multiple-arguments-to-a-function-using/29117/3

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
