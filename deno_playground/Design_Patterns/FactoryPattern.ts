interface Phone {
    brand: string;
    call(): string;
}

abstract class PhoneCreator {
    public abstract factory(): Phone;
}

class MotorolaCreator extends PhoneCreator {
    public factory() {
        return new Motorola();
    }
}

class IphoneCreator extends PhoneCreator {
    public factory() {
        return new Iphone();
    }
}

class Iphone implements Phone {
    public brand = "iPhone";
    public call(): string {
        return "liiiiii liii";
    }
}

class Motorola implements Phone {
    public brand: string = "Motorola";
    public call(): string {
        return "tirim tirm";
    }
}

const moto = new MotorolaCreator().factory();
const iphone = new IphoneCreator().factory();

console.log(moto, iphone);
