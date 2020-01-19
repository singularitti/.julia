#=
project: Settings for a project
- Julia version: 1.0
- Author: singularitti
- Date: 2019-07-18
=#
Pkg.activate(".")

atreplinit() do repl
    try
        @eval using Revise
        @async Revise.wait_steal_repl_backend()
    catch
    end
end
