import IntCode from "./IntCode.ts";
import UserInput from "./UserInput.ts";

const input: string = await Deno.readTextFile("input");

new IntCode(input).toggleDebug().start();
