import { iKeplerPlanet } from "../types.ts";

/**
 * This is a helper function to clean data from NASA e return the most possible planets to be a planet.
 * @param {iKeplerPlanet} planet The kepler planet to be filtered
 */
export default function filteringPlanets(planet: iKeplerPlanet) {
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
