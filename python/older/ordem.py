x = [0,2,6,8,3,10,9,1,21,33,14,112]
y = 2
c = 4


print(x[x[x[7]]]) # -> x[7] = 1
print(x[x[1]]) # -> x[1] = 2
print(x[2]) # -> x[2] = 6
print(6) # -> saída 6


def mostra_zero():
    print(0)

mostra_zero(mostra_zero(mostra_zero(mostra_zero())))