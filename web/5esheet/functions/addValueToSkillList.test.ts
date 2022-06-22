import { addValueToSkillList } from "./addValueToSkillList";

describe("functions/addValueToSkillList", () => {
  test("Should add the proficiency to the skill", () => {
    const profBonus = 2;
    const testSkill = { name: "Test Skill", short: "TST", profMultiplier: 1 };
    const testStat = { name: "Test Stat", short: "TST", value: 12, mod: 1, weight: 0, isProf: false };

    const list = addValueToSkillList({
      profBonus,
      skills: [testSkill],
      stats: [testStat],
    });

    expect(list[0].value).toBe(3);
  });

  test("If no stat match with the skill, the base value is zero", () => {
    const profBonus = 2;
    const testSkill = { name: "Test Skill", short: "TST", profMultiplier: 0 };

    const list = addValueToSkillList({
      profBonus,
      skills: [testSkill],
      stats: [],
    });

    expect(list[0].value).toBe(0);
  });
});
