using LinearAlgebra
using Combinatorics
function bases(A, b , c )
    x=length(b)
    extremos= Dict( )
        for i in 1:x
            push!(c,0)
            a=[0 for y=1:x]
            if b[i]<0
                A[[i],:] = -A[[i],:]
                b[i]= -b[i]
                a[i]=-1
            else
                a[i]=1
            end
            A = hcat(A,a)
        end
        tamano=size(A,2)
        columnas=collect(combinations(1:tamano,x))
        for i in 1: length(columnas)
            B=A[:,columnas[i]]
            punto=pinv(Float32.(B))*b
            contador=0
            for j in 1:x
                if punto[j]<0
                    contador=contador+1
                end
            end
            if contador==0
                basica =[0.0 for y=1:tamano]
                for k in 1:x
                    basica[(columnas[i])[k]]=punto[k]
                end
                punto=basica[1:(tamano-x)]
                if punto in keys(extremos)
                    continue
                else
                    extremos[punto]=basica
                end
            end
        end
    return(extremos)
end

#------ Ejemplo 1
A = [3 -3 2; -1 2 1]
b = [3; 6]
c = [3, 2, 1]
resultado = bases(A,b,c)
println(resultado)

#--- Ejemplo 2

A2 = [1 2 2 4; 2 -1 1 2; 4 -2 1 -1]
b2 = [40; 8; 10]
c2 = [2, 1, -3, 5]
resultado2 = bases(A2, b2, c2)

println(resultado2)

#--- Ejemplo 3
A3 = [-1 -1; -1 1; 1 -1]
b3 = [-1, 3, 3]
c3 = [-3, 3]
resultado3 = bases(A3, b3, c3)
println(resultado3)
