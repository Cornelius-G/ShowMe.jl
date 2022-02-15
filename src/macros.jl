export @showme 
export @showstep
export @showstop

macro showme(variable)
    quote
        name = $(string(variable))
        value = $(esc(variable))
        print_infos(name, value)
    end
end

macro showme(variable, args...)
    kwargs = Pair{Symbol,Any}[]
    for el in args
        if Meta.isexpr(el, :(=))
            push!(kwargs, Pair(el.args...))
        end
    end

    quote
        name = $(string(variable))
        value = $(esc(variable))
        print_infos(name, value; $kwargs...)
    end
end


macro showstep(variable)
    quote
        name = $(string(variable))
        value = $(esc(variable))
        print_infos(name, value)
        print_continue()
        readline()
    end
end

macro showstep(variable, args...)
    kwargs = Pair{Symbol,Any}[]
    for el in args
        if Meta.isexpr(el, :(=))
            push!(kwargs, Pair(el.args...))
        end
    end

    quote
        name = $(string(variable))
        value = $(esc(variable))
        print_infos(name, value; $kwargs...)
        print_continue(; $kwargs...)
        readline()
    end
end


macro showstop(variable)
    quote
        name = $(string(variable))
        value = $(esc(variable))
        print_infos(name, value)

        throw(StopHereException())
    end
end

macro showstop(variable, args...)
    kwargs = Pair{Symbol,Any}[]
    for el in args
        if Meta.isexpr(el, :(=))
            push!(kwargs, Pair(el.args...))
        end
    end

    quote
        name = $(string(variable))
        value = $(esc(variable))
        print_infos(name, value; $kwargs...)

        throw(StopHereException())
    end
end
