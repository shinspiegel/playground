import log from "./src/logger.ts";
import { iFlight } from "./types.ts";

log.warning("HARD");

async function downloadLaunchData() {
    log.info("Fetching data");
    const url = "https://api.spacexdata.com/v3/launches";
    const data: object[] = await fetch(url)
        .then((r) => r.json())
        .catch((e) => log.error("Failed to load data", e.message));

    // console.log(data[0]);

    const flights = data.map(mappetToFlight);

    console.table(flights);
}

function mappetToFlight(item: any): iFlight {
    return {
        rocket: item?.rocket?.rocket_name,
        mission_name: item?.mission_name,
        launch_year: item?.launch_year,
        flight_number: item?.flight_number,
        launch_success: item?.launch_success,
        customer: item?.rocket?.second_stage?.payloads
            ?.map((i: any) => i?.customers)
            .flat(Infinity)
            .join(","),
    };
}

await downloadLaunchData();
