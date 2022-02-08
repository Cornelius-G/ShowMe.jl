export @showme 
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

macro showstop(variable)
    quote
        try
            name = $(string(variable))
            value = $(esc(variable))
            print_infos(name, value)

            ERROR  # throws an error to stop further code execution
        catch error  # catches the error and supresses stacktrace
            return nothing
        end
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
        try
            name = $(string(variable))
            value = $(esc(variable))
            print_infos(name, value; $kwargs...)

            ERROR  # throws an error to stop further code execution
        catch error  # catches the error and supresses stacktrace
            return nothing
        end
    end
end




# myi() = myh()
# myh() = myg()
# myg() = myf()

# function myf()
#     for i in 1:10
#         println("I'm myf")
#         a = [1, 2, 3]
#         @showme a_in_myf = a 
#         println("myf out")
#     end
# end
# myi()

# r = rand(100)
# myvar = (1, 2, 3, 4, 5, 6)
# mycor = rand(4)

# @showme myvar

# st = "This is a quite lon string."
# s = "1:10"
# ss = Meta.parse(s)
# st[s]