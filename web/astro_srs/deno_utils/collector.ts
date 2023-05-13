import { DOMParser } from "https://deno.land/x/deno_dom/deno-dom-wasm.ts";

const collect_list = [
  // Base class
  { type: "base_class", name: "fighter", link: "http://www.trpggasuki.com/alshard/alf_figh.php" },
  { type: "base_class", name: "scout", link: "http://www.trpggasuki.com/alshard/alf_scou.php" },
  { type: "base_class", name: "black magician", link: "http://www.trpggasuki.com/alshard/alf_blac.php" },
  { type: "base_class", name: "white mage", link: "http://www.trpggasuki.com/alshard/alf_whit.php" },

  // Other
  { type: "other", name: "outlaw", link: "http://www.trpggasuki.com/alshard/alf_outl.php" },
  { type: "other", name: "Vagrantz", link: "http://www.trpggasuki.com/alshard/alf_vagr.php" },
  { type: "other", name: "Wizard", link: "http://www.trpggasuki.com/alshard/alf_wiza.php" },
  { type: "other", name: "alias", link: "http://www.trpggasuki.com/alshard/alf_alia.php" },
  { type: "other", name: "Agent", link: "http://www.trpggasuki.com/alshard/alf_agen.php" },
  { type: "other", name: "Elementaler", link: "http://www.trpggasuki.com/alshard/alf_elem.php" },
  { type: "other", name: "Oracle", link: "http://www.trpggasuki.com/alshard/alf_orac.php" },
  { type: "other", name: "cavalry", link: "http://www.trpggasuki.com/alshard/alf_cava.php" },
  { type: "other", name: "samurai", link: "http://www.trpggasuki.com/alshard/alf_samu.php" },
  { type: "other", name: "jar head", link: "http://www.trpggasuki.com/alshard/alf_jarh.php" },
  { type: "other", name: "sorcerer", link: "http://www.trpggasuki.com/alshard/alf_sorc.php" },
  { type: "other", name: "Zoldat", link: "http://www.trpggasuki.com/alshard/alf_zold.php" },
  { type: "other", name: "dark one", link: "http://www.trpggasuki.com/alshard/alf_dark.php" },
  { type: "other", name: "ninja", link: "http://www.trpggasuki.com/alshard/alf_ninj.php" },
  { type: "other", name: "barbarian", link: "http://www.trpggasuki.com/alshard/alf_barb.php" },
  { type: "other", name: "hunter", link: "http://www.trpggasuki.com/alshard/alf_hunt.php" },
  { type: "other", name: "Panzer Ritter", link: "http://www.trpggasuki.com/alshard/alf_panz.php" },
  { type: "other", name: "bright night", link: "http://www.trpggasuki.com/alshard/alf_brig.php" },
  { type: "other", name: "Missional", link: "http://www.trpggasuki.com/alshard/alf_miss.php" },

  //Races
  { type: "race", name: "Alf", link: "http://www.trpggasuki.com/alshard/alf_alf.php" },
  { type: "race", name: "Vahana", link: "http://www.trpggasuki.com/alshard/alf_vaha.php" },
  { type: "race", name: "Valkyrie", link: "http://www.trpggasuki.com/alshard/alf_valk.php" },
  { type: "race", name: "ogre", link: "http://www.trpggasuki.com/alshard/alf_ogre.php" },
  { type: "race", name: "Zaurus", link: "http://www.trpggasuki.com/alshard/alf_saur.php" },
  { type: "race", name: "Sirius", link: "http://www.trpggasuki.com/alshard/alf_siri.php" },
  { type: "race", name: "Dwerg", link: "http://www.trpggasuki.com/alshard/alf_dwar.php" },
  { type: "race", name: "Fairy", link: "http://www.trpggasuki.com/alshard/alf_fair.php" },
  { type: "race", name: "Mellow", link: "http://www.trpggasuki.com/alshard/alf_melo.php" },
  { type: "race", name: "Lynx", link: "http://www.trpggasuki.com/alshard/alf_linx.php" },

  // Advanced
  { type: "advanced", name: "arc wizard", link: "http://www.trpggasuki.com/alshard/alf_arch.php" },
  { type: "advanced", name: "Ideal Sorcerer", link: "http://www.trpggasuki.com/alshard/alf_idea.php" },
  { type: "advanced", name: "Commander", link: "http://www.trpggasuki.com/alshard/alf_comm.php" },
  { type: "advanced", name: "spirit", link: "http://www.trpggasuki.com/alshard/alf_spir.php" },
  { type: "advanced", name: "Centurion", link: "http://www.trpggasuki.com/alshard/alf_cent.php" },
  { type: "advanced", name: "daemon", link: "http://www.trpggasuki.com/alshard/alf_demo.php" },
  { type: "advanced", name: "dragon", link: "http://www.trpggasuki.com/alshard/alf_drag.php" },
  { type: "advanced", name: "Priest", link: "http://www.trpggasuki.com/alshard/alf_prie.php" },
  { type: "advanced", name: "high alf", link: "http://www.trpggasuki.com/alshard/alf_high.php" },

  // ainherial class
  { type: "ainherial", name: "battle master", link: "http://www.trpggasuki.com/alshard/alf_batt.php" },
  { type: "ainherial", name: "Strider", link: "http://www.trpggasuki.com/alshard/alf_stri.php" },
  { type: "ainherial", name: "Warlock", link: "http://www.trpggasuki.com/alshard/alf_warr.php" },
  { type: "ainherial", name: "Guardian", link: "http://www.trpggasuki.com/alshard/alf_guar.php" },
];

const final_result: any = [];

// for (const c of collect_list) {
//   console.log("Collecting for: ", c);
//   const doc = await generateDocument(c.link);

//   const data = await collect(doc);

//   console.log("Collecting for: ", data);
//   final_result.push({
//     name: c.name,
//     type: c.type,
//     ...data,
//   });
// }

const c = { type: "other", name: "Agent", link: "http://www.trpggasuki.com/alshard/alf_agen.php" };
const doc = await generateDocument(c.link);
const data = await collect(doc);

final_result.push({
  name: c.name,
  type: c.type,
  ...data,
});

console.log(final_result);

Deno.writeFileSync("agent.json", new TextEncoder().encode(JSON.stringify(final_result)));

async function generateDocument(url: any) {
  const page = await fetch(url);
  const page_string = await page.text();
  const document = new DOMParser().parseFromString(page_string, "text/html");

  return document;
}

function collect(document: any) {
  const class_name = document.querySelector("h2").innerText;
  const table = [...document.querySelectorAll("table")][0];
  const entries = [...table.querySelectorAll("td")];

  let skills = [];

  for (let i = 0; i < entries.length; i += 4) {
    skills.push({
      name: entries[i].innerText,
      level: entries[i + 1].innerText,
      page: entries[i + 2].innerText,
      company: entries[i + 3].innerText,
    });
  }

  return {
    class_name,
    skills,
  };
}
