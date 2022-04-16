import { BufReader, parseCSV, path } from "../deps.ts";
import { iKeplerPlanet } from "../type.ts";

export default class Planet {
    static async getPlanets() {
        const filePath = path.join("csv", "kepler_exoplanets_nasa.csv");
        const planets = await Planet.loadPlanetsData<iKeplerPlanet>(filePath);
        const filtered = planets.filter(Planet.filteringPlanets);
        return filtered;
    }

    /**
     * This function receives a generic T as the result type of the parse file.
     * @param {string} path The path to the CSV file to be parsed.
     */
    private static async loadPlanetsData<T>(path: string) {
        const file = await Deno.open(path);
        const bufReader = new BufReader(file);
        const result = (await parseCSV(bufReader, {
            skipFirstRow: true,
            comment: "#",
        })) as T[];

        Deno.close(file.rid); //Need to close file
        return result;
    }

    /**
     * This is a helper function to clean data from NASA e return the most possible planets to be a planet.
     * @param {iKeplerPlanet} planet The kepler planet to be filtered
     */
    private static filteringPlanets(planet: iKeplerPlanet) {
        const planetRadius = planet.koi_prad;
        const starMass = planet.koi_smass;
        const startRadius = planet.koi_srad;

        if (planet.koi_disposition !== "CONFIRMED") {
            return false;
        }

        if (planetRadius < 0.5 || planetRadius > 1.5) {
            return false;
        }

        if (starMass < 0.78 || starMass > 1.04) {
            return false;
        }

        if (startRadius < 0.99 || startRadius > 1.01) {
            return false;
        }

        return true;
    }
}
