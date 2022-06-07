import { Table } from "../types/index.ts";

export const raceRelation: Table = {
  table: "Race Relations",
  options: [
    { weight: 10, option: "Harmony" },
    { weight: 4, option: "Tension or rivalry" },
    { weight: 2, option: "Racial majority are conquerors" },
    { weight: 1, option: "Racial minority are rulers" },
    { weight: 1, option: "Racial minority are refugees" },
    { weight: 1, option: "Racial majority oppresses minority" },
    { weight: 1, option: "Racial minority oppresses majority" },
  ],
};

export const rulerStatus: Table = {
  table: "Ruler's Status",
  options: [
    { weight: 5, option: "Respected, fair, and just" },
    { weight: 3, option: "Feared tyrant" },
    { weight: 1, option: "Weakling manipulated by others" },
    { weight: 1, option: "Illegitimate ruler, simmering civil war" },
    { weight: 1, option: "Ruled or controlled by a powerful monster" },
    { weight: 1, option: "Mysterious, anonymous cabal" },
    { weight: 1, option: "Contested leadership, open fighting" },
    { weight: 1, option: "Cabal seized power openly" },
    { weight: 1, option: "Doltish lout" },
    { weight: 1, option: "On deathbed, claimants compete for power" },
    { weight: 2, option: "Iron-willed but respected" },
    { weight: 2, option: "Religious leader" },
  ],
};

export const notableTraits: Table = {
  table: "Notable Traits",
  options: [
    { weight: 1, option: "Canals in place of streets" },
    { weight: 1, option: "Massive statue or monument" },
    { weight: 1, option: "Grand temple" },
    { weight: 1, option: "Large fortress" },
    { weight: 1, option: "Verdant parks and orchards" },
    { weight: 1, option: "River divides town" },
    { weight: 1, option: "Major trade center" },
    { weight: 1, option: "Headquarters of a powerful family or guild" },
    { weight: 1, option: "Population mostly wealthy" },
    { weight: 1, option: "Destitute, rundown" },
    { weight: 1, option: "Awful smell (tanneries, open sewers)" },
    { weight: 1, option: "Center of trade for one specific good" },
    { weight: 1, option: "Site of many battles" },
    { weight: 1, option: "Site of a mythic or magical event" },
    { weight: 1, option: "Important library or archive" },
    { weight: 1, option: "Worship of all gods banned" },
    { weight: 1, option: "Sinister reputation" },
    { weight: 1, option: "Notable library or academy" },
    { weight: 1, option: "Site of important tomb or graveyard" },
    { weight: 1, option: "Built atop ancient ruins" },
  ],
};

export const knowFor: Table = {
  table: "Known for it's",
  options: [
    { weight: 1, option: "Delicious cuisine" },
    { weight: 1, option: "Rude people" },
    { weight: 1, option: "Greedy merchants" },
    { weight: 1, option: "Artists and writers" },
    { weight: 1, option: "Great hero/savior" },
    { weight: 1, option: "Flowers" },
    { weight: 1, option: "Hordes of beggars" },
    { weight: 1, option: "Tough warriors" },
    { weight: 1, option: "Dark magic" },
    { weight: 1, option: "Decadence" },
    { weight: 1, option: "Piety" },
    { weight: 1, option: "Gambling" },
    { weight: 1, option: "Godlessness" },
    { weight: 1, option: "Education" },
    { weight: 1, option: "Wines" },
    { weight: 1, option: "High fashion" },
    { weight: 1, option: "Political intrigue" },
    { weight: 1, option: "Powerful guilds" },
    { weight: 1, option: "Strong drink" },
    { weight: 1, option: "Patriotism" },
  ],
};

export const currentCalamity: Table = {
  table: "Current Calamity",
  options: [
    { weight: 1, option: "Suspected vampire infestation" },
    { weight: 1, option: "New cult seeks converts" },
    { weight: 1, option: "Important figure died (murder suspected)" },
    { weight: 1, option: "War between rival thieves' guilds" },
    { weight: 2, option: "Plague or famine (sparks riots)" },
    { weight: 1, option: "Corrupt officials" },
    { weight: 2, option: "Marauding monsters" },
    { weight: 1, option: "Powerful wizard has moved into town" },
    { weight: 1, option: "Economic depression (trade disrupted)" },
    { weight: 1, option: "Flooding" },
    { weight: 1, option: "Undead stirring in cemeteries" },
    { weight: 1, option: "Prophecy of doom" },
    { weight: 1, option: "Brink of war" },
    { weight: 1, option: "Internal strife (leads to anarchy)" },
    { weight: 1, option: "Besieged by enemies" },
    { weight: 1, option: "Scandal threatens powerful families" },
    { weight: 1, option: "Dungeon discovered (adventurers flock to town)" },
    { weight: 1, option: "Religious sects struggle for power" },
  ],
};

export const buildingType: Table = {
  table: "Building Type",
  options: [
    { weight: 10, option: "Residence (roll once on Residence table)" },
    { weight: 2, option: "Religious (roll once on Religious Building table)" },
    { weight: 3, option: "Tavern (roll once on the Tavern table and twice on the Tavern Name Generator Table)" },
    { weight: 2, option: "Warehouse (roll once on the Warehouse table)" },
    { weight: 3, option: "Shop (roll once on the Shop table)" },
  ],
};

export const buildingResidence: Table = {
  table: "Residence",
  options: [
    { weight: 2, option: "Abandoned squat" },
    { weight: 6, option: "Middle-class home" },
    { weight: 2, option: "Upper-class home" },
    { weight: 5, option: "Crowded tenement" },
    { weight: 2, option: "Orphanage" },
    { weight: 1, option: "Hidden thieves' den" },
    { weight: 1, option: "Front for a secret cult" },
    { weight: 1, option: "Lavish, guarded mansion" },
  ],
};

export const buildingReligious: Table = {
  table: "Religious",
  options: [
    { weight: 10, option: "Temple to a good or neutral deity" },
    { weight: 2, option: "Temple to a false deity (run by charlatan priests)" },
    { weight: 1, option: "Home of ascetics" },
    { weight: 2, option: "Abandoned shrine" },
    { weight: 2, option: "Library dedicated to religious study" },
    { weight: 3, option: "Hidden shrine to a fiend or an evil deity" },
  ],
};
