import { path } from "./deps.ts";
import { iKeplerPlanet } from "./types.ts";
import loadPlanetsData from "./src/loadPlanets.ts";
import filteringPlanets from "./src/feilteringKepler.ts";

const filePath = path.join("csv", "kepler_exoplanets_nasa.csv");
const planets = await loadPlanetsData<iKeplerPlanet>(filePath);
const filtered = planets.filter(filteringPlanets);

console.log(
    `The total planets on the raw file is: ${planets.length}, 
and after the filtering have found ${filtered.length} planets.`
);

console.log("\n This is the planets found:");

console.table(
    filtered.map((p) => ({
        planet_name: p.kepler_name,
        planet_radius: Number(p.koi_prad),
        system_planets: Number(p.koi_count),
        star_mass: Number(p.koi_smass),
        star_radius: Number(p.koi_srad),
        star_temp_k: Number(p.koi_steff),
        star_temp_c: Number(p.koi_steff) - 273.15,
    }))
);
