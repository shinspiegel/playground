function pegaCoisaEMuda(coisa) {
    coisa.nome = "Eduardo"
}

var pessoa = { // 0x228dfaa37
    idade: 30,
    nome: "João"
}

console.log("Primeiro é", pessoa.nome)

pegaCoisaEMuda(pessoa)  // 0x228dfaa37
//Se passa primitivo -> Cópia
//Se passa objeto -> Referência

console.log("Segundo é", pessoa.nome)
