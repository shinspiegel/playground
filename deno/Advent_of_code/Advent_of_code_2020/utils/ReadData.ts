export default class ReadData {
    static async fromFile<T>(file: string, mapper: (v: string) => T): Promise<T[]> {
        const input = await Deno.readTextFile(file);
        const data: T[] = input.split("\n").map(mapper);
        return data;
    }
}
