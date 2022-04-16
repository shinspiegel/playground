document
    .getElementById("calcular")
    .addEventListener("click", 
        () => {
        const col = new Colaborador(
            document.getElementById("horas").value,
            document.getElementById("custoHora").value
        );

        resultado.value = col.calcularHoras();
    });

class Colaborador {
    constructor(horas, custoHora) {
        this.horas = horas;
        this.custoHora = custoHora;
    }

    calcularHoras() {
        return this.horas * this.custoHora;
    }
}
