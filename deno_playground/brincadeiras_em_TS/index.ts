class Retangulo {
    constructor(x, y) {
        this.x = x;
        this.y = y;
    }

    setValueY(y) {
        this.y = y
        return this
    }

    setValueX(x) {
        this.x = x
        return this
    }

    calculoArea() {
        console.log("Calculo", this.x * this.y)
        return this
    }
}

var meuRetangulo = new Retangulo(10, 20); 
meuRetangulo = meuRetangulo.setValueX(5).calculoArea()
meuRetangulo = meuRetangulo