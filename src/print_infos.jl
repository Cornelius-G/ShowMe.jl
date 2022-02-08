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

    varsize = try  # catch cases where 'size' is not defined, e.g. for a NamedTuple
        size(varvalue) 
    catch error 
        () 
    end
    varsize == () ? show_size = false : nothing

    len = if varsize == () && !isa(varvalue, Number)
        try 
            length(varvalue) 
        catch e 
            show_length = false 
        end
    else
        show_length = false
    end

    show_name ? printstyled(stderr, varname*":\n", bold=true, color=color, underline=true) : nothing

    show_type ? printstyled(stderr, " type:   "*string(vartype)*"\n", color=color) : nothing
    show_size ? printstyled(stderr, " size:   "*string(varsize)*"\n", color=color) : nothing
    show_length ? printstyled(stdout, " length: "*string(len)*"\n", color=color) : nothing
    show_value ? printstyled(stdout, " value:  "*string(varvalue)[eval(value_length)]*"\n", color=color) : nothing
end