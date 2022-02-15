using Pkg
Pkg.activate(abspath(@__DIR__))
Pkg.instantiate()


using ShowMe

a = 3
@showme a

b = rand(10)
@showstep b

c = rand(100, 100)
@showme c value_length=1:50
@showme c[1:10, 1:10] value_length=1:100


function f4()
    println("Hi, im f4!")
    @showstop a = rand(5, 5)
    println("Bye")
end

function f3()
    f4()
end

function f2()
    for i in 1:10
        f3()
    end
end

function f1()
    f2()
end


f1()


