import { Table } from "../types/index.ts";

export const races: Table = {
  table: "Random Race",
  options: [
    { weight: 50, option: "Human" },
    { weight: 25, option: "Dwarf" },
    { weight: 25, option: "Elf" },
    { weight: 25, option: "Halfling" },
    { weight: 15, option: "Half-elf" },
    { weight: 15, option: "Gnome" },
    { weight: 10, option: "Half-Orc" },
    { weight: 7, option: "Dragonborn" },
    { weight: 6, option: "Tiefling" },

    { weight: 1, option: "Aasimar" },
    { weight: 1, option: "Aarakocra" },
    { weight: 1, option: "Centaur" },
    { weight: 1, option: "Changeling" },
    { weight: 1, option: "Firbolg" },
    { weight: 1, option: "Genasi" },
    { weight: 1, option: "Gith" },
    { weight: 1, option: "Goliath" },
    { weight: 1, option: "Kalashtar" },
    { weight: 1, option: "Kenku" },
    { weight: 1, option: "Lizardfolk" },
    { weight: 1, option: "Loxodon" },
    { weight: 1, option: "Minotaur" },
    { weight: 1, option: "Monstrous" },
    { weight: 2, option: "Shifter" },
    { weight: 1, option: "Simic Hybrid" },
    { weight: 1, option: "Tabaxi" },
    { weight: 1, option: "Tortle" },
    { weight: 1, option: "Triton" },
    { weight: 1, option: "Vedalken" },
    { weight: 1, option: "Warforged" },
  ],
};

export const monstrous: Table = {
  table: "Monstrous",
  options: [
    { weight: 1, option: "Bugbear" },
    { weight: 1, option: "Goblin" },
    { weight: 1, option: "Dhampir" },
    { weight: 1, option: "Fairy" },
    { weight: 1, option: "Kobold" },
    { weight: 1, option: "Leonin" },
    { weight: 1, option: "Owlin" },
    { weight: 1, option: "Satyr" },
    { weight: 1, option: "Yuan-ti Pureblood" },
  ],
};

export const human: Table = {
  table: "Human",
  options: [
    { weight: 50, option: "Base" },
    { weight: 5, option: "Variant" },
    { weight: 1, option: "Mark of Finding" },
    { weight: 1, option: "Mark of Handling" },
    { weight: 1, option: "Mark of Making" },
    { weight: 1, option: "Mark of Passage" },
    { weight: 1, option: "Mark of Sentinel" },
  ],
};

export const dwarf: Table = {
  table: "Dwarf",
  options: [
    { weight: 30, option: "Mountain" },
    { weight: 30, option: "Hill" },
    { weight: 5, option: "Duegar" },
    { weight: 1, option: "Mark of Warding" },
  ],
};

export const elf: Table = {
  table: "Elf",
  options: [
    { weight: 30, option: "High" },
    { weight: 30, option: "Wood" },
    { weight: 5, option: "Eladrin" },
    { weight: 5, option: "Drow" },
    { weight: 1, option: "Pallid" },
    { weight: 1, option: "Sea" },
    { weight: 1, option: "Shadar-kai" },
    { weight: 1, option: "Mark of Shadow" },
  ],
};

export const halfling: Table = {
  table: "Halfling",
  options: [
    { weight: 30, option: "Stout" },
    { weight: 30, option: "Lightfoot" },
    { weight: 2, option: "Ghostwise" },
    { weight: 2, option: "Lotusden" },
    { weight: 1, option: "Mark of Healing" },
    { weight: 1, option: "Mark of Hospitality" },
  ],
};

export const halfElf: Table = {
  table: "Half-elf",
  options: [
    { weight: 50, option: "Base" },
    { weight: 2, option: "Aquatic Decedent" },
    { weight: 2, option: "Moon Decedent" },
    { weight: 2, option: "Wood Decedent" },
    { weight: 2, option: "Sun Decedent" },
    { weight: 1, option: "Drow Decedent" },
    { weight: 1, option: "Mark of Detection" },
    { weight: 1, option: "Mark of Storm" },
  ],
};

export const gnome: Table = {
  table: "Gnome",
  options: [
    { weight: 25, option: "Rock" },
    { weight: 25, option: "Forest" },
    { weight: 5, option: "Deep" },
    { weight: 1, option: "Mark of Scribing" },
  ],
};

export const halfOrc: Table = {
  table: "Half-orc",
  options: [
    { weight: 50, option: "Base" },
    { weight: 1, option: "Mark of Finding" },
  ],
};

export const dragonboen: Table = {
  table: "Dragonborn",
  options: [
    { weight: 10, option: "Base, Black" },
    { weight: 10, option: "Base, Blue" },
    { weight: 10, option: "Base, Brass" },
    { weight: 10, option: "Base, Bronze" },
    { weight: 10, option: "Base, Copper" },
    { weight: 10, option: "Base, Gold" },
    { weight: 10, option: "Base, Green" },
    { weight: 10, option: "Base, Red" },
    { weight: 10, option: "Base, Silver" },
    { weight: 10, option: "Base, White" },

    { weight: 1, option: "Chromatic, Black" },
    { weight: 1, option: "Chromatic, Blue" },
    { weight: 1, option: "Chromatic, Green" },
    { weight: 1, option: "Chromatic, Red" },
    { weight: 1, option: "Chromatic, White" },

    { weight: 1, option: "Draconblood, Black" },
    { weight: 1, option: "Draconblood, Blue" },
    { weight: 1, option: "Draconblood, Brass" },
    { weight: 1, option: "Draconblood, Bronze" },
    { weight: 1, option: "Draconblood, Copper" },
    { weight: 1, option: "Draconblood, Gold" },
    { weight: 1, option: "Draconblood, Green" },
    { weight: 1, option: "Draconblood, Red" },
    { weight: 1, option: "Draconblood, Silver" },
    { weight: 1, option: "Draconblood, White" },

    { weight: 1, option: "Gem, Amethyst" },
    { weight: 1, option: "Gem, Crystal" },
    { weight: 1, option: "Gem, Emerald" },
    { weight: 1, option: "Gem, Sapphire" },
    { weight: 1, option: "Gem, Topaz" },

    { weight: 1, option: "Metallic, Brass" },
    { weight: 1, option: "Metallic, Bronze" },
    { weight: 1, option: "Metallic, Copper" },
    { weight: 1, option: "Metallic, Gold" },
    { weight: 1, option: "Metallic, Silver" },

    { weight: 1, option: "Ravenite, Black" },
    { weight: 1, option: "Ravenite, Blue" },
    { weight: 1, option: "Ravenite, Brass" },
    { weight: 1, option: "Ravenite, Bronze" },
    { weight: 1, option: "Ravenite, Copper" },
    { weight: 1, option: "Ravenite, Gold" },
    { weight: 1, option: "Ravenite, Green" },
    { weight: 1, option: "Ravenite, Red" },
    { weight: 1, option: "Ravenite, Silver" },
    { weight: 1, option: "Ravenite, White" },
  ],
};

export const tiefling: Table = {
  table: "Tiefling",
  options: [
    { weight: 50, option: "Base" },
    { weight: 1, option: "Asmodeus" },
    { weight: 1, option: "Baalzebul" },
    { weight: 1, option: "Dispater" },
    { weight: 1, option: "Fierna" },
    { weight: 1, option: "Glasya" },
    { weight: 1, option: "Levistus" },
    { weight: 1, option: "Mammon" },
    { weight: 1, option: "Mephistopheles" },
    { weight: 1, option: "Devil's Tongue" },
    { weight: 1, option: "Hellfire" },
    { weight: 1, option: "Winged" },
    { weight: 1, option: "Zariel" },
  ],
};

export const aasimar: Table = {
  table: "Aasimar",
  options: [
    { weight: 50, option: "Base" },
    { weight: 1, option: "Fallen" },
    { weight: 1, option: "Protector" },
    { weight: 1, option: "Scourge" },
  ],
};

export const genasi: Table = {
  table: "Genasi",
  options: [
    { weight: 1, option: "Air" },
    { weight: 1, option: "Earth" },
    { weight: 1, option: "Fire" },
    { weight: 1, option: "Water" },
  ],
};

export const gith: Table = {
  table: "Gith",
  options: [
    { weight: 1, option: "Githyanki" },
    { weight: 1, option: "Githzerai" },
  ],
};

export const shifter: Table = {
  table: "Shifter",
  options: [
    { weight: 1, option: "Beasthide" },
    { weight: 1, option: "Longtooth" },
    { weight: 1, option: "Swiftstride" },
    { weight: 1, option: "Wildhunt" },
  ],
};
