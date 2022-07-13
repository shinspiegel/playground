lista_original = [9,2,3,5,6]

def shin_horrivel_sort(lista):
    lista_retorno = []
    vai = True

    while vai:    
        numero_minimo = lista[0]

        for numero in lista:
            if numero < numero_minimo:
                numero_minimo = numero
        
        lista_retorno.append(numero_minimo)

        index = lista.index(numero_minimo)
        del lista[index]
        
        if len(lista) == 0:
            vai = False

    return lista_retorno

    
def bubbleSort(arr):
    tamanho_arr = len(arr)
    trocou = False

    for i in range(tamanho_arr-1):
        for j in range(0, tamanho_arr-i-1):
 
            if arr[j] > arr[j + 1]:
                trocou = True
                arr[j], arr[j + 1] = arr[j + 1], arr[j]
         
        if not trocou:
            return     



print(shin_horrivel_sort(lista_original))
