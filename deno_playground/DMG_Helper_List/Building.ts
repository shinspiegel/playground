import { pickRandom } from "./Tables.ts";
import { randomRange } from "./RandomNumbers.ts";
import { randomNPC, Npc } from "./Npc.ts";

export interface Building {
  name: string;
  type: string;
  subtype: string;
  residents: Npc[];
}

export function randomBuilding() {
  const building = {} as Building;

  building.name = "";
  building.type = pickRandom.BuildingType().data.type;
  building.subtype = selectByType(building.type);
  building.residents = [];

  for (let i = 0; i < randomRange(0, 20); i++) {
    building.residents.push(randomNPC());
  }

  return building;
}

function selectByType(type: string) {
  switch (type) {
    case "residence":
      return pickRandom.Residence().data;

    case "religious":
      return pickRandom.ReligiousBuilding().data;

    case "tavern":
      return pickRandom.Tavern().data;

    case "warehouse":
      return pickRandom.Warehouse().data;

    case "shop":
      return pickRandom.Shop().data;

    default:
      throw new Error("BUILDING:: Invalid option");
  }
}
