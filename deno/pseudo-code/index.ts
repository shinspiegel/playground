var comodos = [
    {largura: 3, profundidade: 3},
    {largura: 5, profundidade: 5},
    {largura: 2, profundidade: 2},
]

var tamanhosDosComodos = []
var resutladoFinal = 0;

for (let i = 0; i < comodos.length; i++) {
    var largura = comodos[i].largura
    var profundidade = comodos[i].profundidade

    var resultado = calcularArea(largura, profundidade)
    tamanhosDosComodos.push(resultado)
}

function calcularArea(largura, profundidade) {
    return largura * profundidade
}

for (let i = 0; i < tamanhosDosComodos.length; i++) {
    resutladoFinal += tamanhosDosComodos[i]
}

console.log("O resutlado final é " + resull)