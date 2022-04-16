const input: string = await Deno.readTextFile("input");
const data: string[] = input.split("\n\n");

class App {
    private count = 0;

    constructor(private groups: string[]) {
        this.start();
    }

    intersection(set1: Set<string>, set2: Set<string>) {
        const finalSet = new Set<string>();

        for (let item of set1) {
            if (set2.has(item)) {
                finalSet.add(item);
            }
        }

        return finalSet;
    }

    start() {
        for (let group of this.groups) {
            const lines = group.split("\n");
            let intersectionSet = new Set(lines[0]);

            for (let line of lines) {
                const lineSet = new Set(line);
                intersectionSet = this.intersection(intersectionSet, lineSet);
            }

            this.count += intersectionSet.size;
        }

        console.log(this.count);
    }
}

new App(data);
