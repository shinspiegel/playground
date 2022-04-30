export function gameLoop() {
  console.clear();
  let isPlaying = true;

  while (isPlaying) {
    console.log("*=================*");
    console.log("Bem-vindo");
    console.log("[1] Jogar");
    console.log("[2] Regras");
    console.log("[3] Sair");
    console.log("*=================*");

    const result = prompt("Escolha: ");

    switch (result) {
      case "1":
        console.clear();
        console.log("Escolheu jogar");
        console.log("Iniciar jogo");
        console.log("Mostrar total de pontos");
        console.log("Mostrar cartas disponíveis");
        console.log("Escolher carta");
        console.log("Escolher valor");
        console.log("Verificar vencedor da rodada");
        console.log("Verificar vencedor da partida");
        prompt("Jogo encerrado");
        console.clear();

        break;

      case "2":
        console.clear();
        console.log("Escolheu regras");
        prompt("Regras encerradas");
        console.clear();

        break;

      case "3":
        console.clear();
        console.log("Escolheu sair");
        isPlaying = false;
        break;

      default:
        console.clear();
        console.log("Não entendi");

        break;
    }
  }
}
