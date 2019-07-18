#!/usr/local/bin/julia
ENV["JULIA_NUM_THREADS"] = 12
ENV["EDITOR"] = "code"
ENV["PYTHON"] = "python"

include("common.jl")
if isfile("Project.toml")
    include("project.jl")
else
    include("standalone.jl")
end
