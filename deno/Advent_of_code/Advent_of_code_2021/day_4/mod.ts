const input = await Deno.readTextFile("input");

type Board = { score?: number; values: Value[] };
type Value = { number: number; isMarked: boolean };

const getBoardData = (data: string) => {
  const [_a, _b, ...rawBoard] = data.split("\n");
  const cleaned = rawBoard
    .join("\n")
    .replaceAll("\n ", "\n")
    .replaceAll("  ", " ")
    .split("\n")
    .filter((n) => n !== "")
    .map((l) => l.split(" "))
    .flat()
    .map((d) => parseInt(d));

  const result: Board[] = [];

  cleaned.forEach((d, i) => {
    if (i % 25 === 0) result.push({ values: [] });

    const last = result[result.length - 1];
    last.values.push({ number: d, isMarked: false });
  });

  return result;
};

const getBallsOrder = (data: string) => {
  return data
    .split("\n")[0]
    .split(",")
    .map((n) => parseInt(n));
};

const isBoardWinner = (board: Board): boolean => {
  for (let i = 0; i < 25; i += 5) {
    if (
      board.values[i].isMarked &&
      board.values[i + 1].isMarked &&
      board.values[i + 2].isMarked &&
      board.values[i + 3].isMarked &&
      board.values[i + 4].isMarked
    ) {
      return true;
    }
  }

  for (let i = 0; i < 5; i++) {
    if (
      board.values[i].isMarked &&
      board.values[i + 5].isMarked &&
      board.values[i + 10].isMarked &&
      board.values[i + 15].isMarked &&
      board.values[i + 20].isMarked
    ) {
      return true;
    }
  }
  return false;
};

const calculateBoardScore = (board: Board, ballValue: number) => {
  const value = board.values
    .filter((c) => !c.isMarked)
    .map((c) => c.number)
    .reduce((p, c) => p + c, 0);

  board.score = value * ballValue;
};

const checkWinnerBoards = (boards: Board[], ballValue: number) => {
  const winner: Board[] = [];

  boards.forEach((board) => {
    if (!board.score && isBoardWinner(board)) {
      calculateBoardScore(board, ballValue);
      winner.push(board);
    }
  });

  return winner;
};

const checkNumberOnBoards = (boards: Board[], ballValue: number) => {
  boards.forEach((board) => {
    board.values.forEach((value) => {
      if (value.isMarked) return;
      if (value.number === ballValue) {
        value.isMarked = true;
      }
    });
  });
};

const playGame = (data: string) => {
  const boardList = getBoardData(data);
  const ballList = getBallsOrder(data);
  let winnerList: Board[] = [];

  ballList.forEach((ball) => {
    checkNumberOnBoards(boardList, ball);

    const lastWinner = checkWinnerBoards(boardList, ball);

    winnerList = [...winnerList, ...lastWinner];
  });

  console.log(winnerList[winnerList.length - 1].score);
};

playGame(input);
