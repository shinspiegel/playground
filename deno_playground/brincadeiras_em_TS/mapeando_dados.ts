const array = [
    { nome: "asd1", idade: 121 },
    { nome: "asd2", idade: 122 },
    { nome: "asd3" },
    { nome: "asd4", idade: 124 },
    { nome: "asd5", idade: 125 },
];

const idades = array.map((i) => i.idade).filter((i) => i !== undefined);

console.log("Idaes", idades);
