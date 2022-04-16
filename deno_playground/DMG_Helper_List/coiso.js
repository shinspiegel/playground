function soma(x, y) {
  return x + y;
}

function somaCurry(x) {
  return function (y) {
    return x + y;
  };
}

var calculaImposto = {
  IRPG: somaCurry(10),
  IRD: somaCurry(1),
  SSGH: somaCurry(5),
};

console.log(soma(10, 20));
console.log(somaCurry(10)(20));
console.log(calculaImposto.IRD(30));
