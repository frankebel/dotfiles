# Startup file for julia.
# See <https://docs.julialang.org/en/v1/manual/command-line-interface/#Startup-file>.

# Add revise in REPL
# See <https://timholy.github.io/Revise.jl/stable/config/#Using-Revise-automatically-within-Jupyter/IJulia-1>
if isinteractive()
    try
        using Revise
    catch e
        @warn "Error initializing Revise" exception = (e, catch_backtrace())
    end
end
