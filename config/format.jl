#=
format: Formatting all Julia files under a package's `src` directory
- Julia version: 1.0
- Author: singularitti
- Date: 2019-07-24
=#
# Thanks for the people who helped me on this question: 
# https://discourse.julialang.org/t/what-is-the-correct-way-to-ignore-some-files-directories-in-walkdir/26780

# Usage: You can run this file directly under your package's `src/` folder,
# which contains all your Julia files (usually).
using JuliaFormatter

const IGNORED_PATHS = (".git", ".idea", ".vscode")

isjuliafile(path::AbstractString) = isfile(path) && splitext(basename(path))[2] == ".jl"

isignored(path) = any(occursin(x, path) for x in IGNORED_PATHS)

function formatjuliafiles(path)
    for (root, dirs, files) in walkdir(path)
        isignored(root) && continue
        for file in files
            !isjuliafile(file) && continue
            println("formatting: " * joinpath(root, file))
            format_file(joinpath(root, file); indent = 4, margin = 120, overwrite = true)
        end
    end
end

formatjuliafiles(pwd())
