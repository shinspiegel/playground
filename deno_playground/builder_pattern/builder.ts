class User {
  private constructor(
    private CPF: string | undefined,
    private CNPJ: string | undefined,
    private age: string | undefined
  ) {}

  static builder() {
    return new (class UserBuilder {
      private CPF = "";
      private CNPJ = "";
      private age = "";

      setCPF(v: string) {
        this.CPF = v;
        return this;
      }

      setCNPJ(v: string) {
        this.CNPJ = v;
        return this;
      }

      setAge(v: string) {
        this.age;
        return this;
      }

      build() {
        if (this.CNPJ && this.CPF) {
          throw new Error("Deu ruim");
        }

        if (this.CNPJ) return new User(undefined, this.CNPJ, this.age);
        if (this.CPF) return new User(this.CPF, undefined, this.age);
      }
    })();
  }
}

const shin = User.builder().setCNPJ("asdadasd").setAge("asdasd").setCPF("123123123").build();

console.log("Data?", shin);
