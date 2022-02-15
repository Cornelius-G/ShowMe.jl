struct StopHereException
end

function Base.showerror(io::IO, ex::StopHereException, bt; backtrace=true)
    # show(io, "Execution stopped by @showstop macro.")
    Base.with_output_color(get(io, :color, false) ? Base.error_color() : :nothing, io) do io
        show(io, "Code execution stopped by @showstop macro.")
    end
end