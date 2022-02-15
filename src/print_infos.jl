function print_infos(
    varname, 
    varvalue; 
    color=:light_yellow, 
    show_type=true,  
    show_size=true,
    show_length=true, 
    show_value=true, 
    show_name=true,
    value_length = 1:length(string(varvalue))
)
    vartype = typeof(varvalue)
    show_size, varsize = get_size(varvalue; show_size=show_size)
    show_length, varlen = get_length(varvalue, varsize; show_length=show_length)

    show_name ? printstyled(stderr, varname*":\n", bold=true, color=color, underline=true) : nothing

    show_type ? printstyled(stderr, " type:   "*string(vartype)*"\n", color=color) : nothing
    show_size ? printstyled(stderr, " size:   "*string(varsize)*"\n", color=color) : nothing
    show_length ? printstyled(stderr, " length: "*string(varlen)*"\n", color=color) : nothing
    show_value ? printstyled(stderr, " value:  "*string(varvalue)[eval(value_length)]*"\n", color=color) : nothing

    printstyled(stderr, "\n", color=color)
end


function get_size(varvalue; show_size)
    varsize = try  # catch cases where 'size' is not defined, e.g. for a NamedTuple
        size(varvalue) 
    catch error 
        () 
    end
    varsize == () ? show_size = false : nothing
    
    return show_size, varsize
end


function get_length(varvalue, varsize; show_length)
    if !isa(varvalue, Number) && varsize == ()
        try 
            len = length(varvalue) 
            return show_length, len
        catch e 
            show_length = false 
            return show_length, nothing
        end
    else
        show_length = false
        return show_length, nothing
    end
end


function print_continue(; color=:light_yellow)
    printstyled(stderr, "Press ENTER to continue...", color=color)
end