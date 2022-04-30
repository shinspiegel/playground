import { readLines } from "https://deno.land/std@0.76.0/io/bufio.ts";

export default class Question {
    public static async ask(question: string) {
        console.log(question);

        for await (const line of readLines(Deno.stdin)) {
            return line;
        }
    }

    public static async askNumber(question: string) {
        console.log(question);

        for await (const line of readLines(Deno.stdin)) {
            const number = Number(line);

            if (!Number.isNaN(number)) {
                return number;
            }

            console.log("Please provide an number.");
        }
    }
}
