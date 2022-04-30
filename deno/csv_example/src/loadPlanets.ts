import { BufReader, parseCSV } from "../deps.ts";

/**
 * This function receives a generic T as the result type of the parse file.
 * @param {string} path The path to the CSV file to be parsed.
 */
export default async function loadPlanetsData<T>(path: string) {
    const file = await Deno.open(path);
    const bufReader = new BufReader(file);
    const result = (await parseCSV(bufReader, {
        skipFirstRow: true,
        comment: "#",
    })) as T[];

    Deno.close(file.rid); //Need to close file
    return result;
}
