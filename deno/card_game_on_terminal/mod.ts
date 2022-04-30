// import { gameLoop } from "./src/GameLoop.ts";

// gameLoop();

const date = new Date("2021-07-02T08:00");
const oneHour = 1000 * 60 * 60;
const seventyTwo = oneHour * 72;

const validDate = new Date(date.getTime() + seventyTwo);
console.log({ date, validDate });
