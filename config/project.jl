#=
project: Settings for a project
- Julia version: 1.0
- Author: singularitti
- Date: 2019-07-18
=#
using Pkg

# using Debugger

pkg"activate ."

atreplinit() do repl
    @async try
        sleep(0.1)
        @eval using Revise
        @async Revise.wait_steal_repl_backend()
    catch
        @warn("Could not load Revise.")
    end
    
    @async try
        sleep(0.1)
        @eval using Rebugger
    catch
        @warn "Could not load Rebugger."
    end
end
