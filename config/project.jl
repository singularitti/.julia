#=
project: Settings for a project
- Julia version: 1.0
- Author: singularitti
- Date: 2019-07-18
=#
using Pkg

# using Debugger
# using Rebugger

push!(LOAD_PATH, pwd())

pkg"activate ."

macro loadproj()
    proj = Pkg.TOML.parsefile("Project.toml")["name"] |> Symbol
    eval(:(using $proj))
end

macro loaddeps()
    deps = Pkg.TOML.parsefile("Project.toml")["deps"]
    for dep in map(Symbol, collect(keys(deps)))
        eval(:(using $dep))
    end
end

atreplinit() do repl
    @async try
        sleep(0.1)
        @eval using Revise
        @async Revise.wait_steal_repl_backend()
    catch
        @warn("Could not load Revise.")
    end
end
