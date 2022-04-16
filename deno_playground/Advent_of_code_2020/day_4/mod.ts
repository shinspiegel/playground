// byr (Birth Year)
// iyr (Issue Year)
// eyr (Expiration Year)
// hgt (Height)
// hcl (Hair Color)
// ecl (Eye Color)
// pid (Passport ID)
// cid (Country ID)

import Validator from "./Validator.ts";

class Passport {
    public birthYear: number | undefined = undefined;
    public issueYear: number | undefined = undefined;
    public expirationYear: number | undefined = undefined;
    public height: string | undefined = undefined;
    public hairColor: string | undefined = undefined;
    public eyeColor: string | undefined = undefined;
    public passportID: string | undefined = undefined;
    public countryID: string | undefined = undefined;

    insertByCode(code: string, value: string) {
        if (code === "byr") this.birthYear = Number(value);
        if (code === "iyr") this.issueYear = Number(value);
        if (code === "eyr") this.expirationYear = Number(value);
        if (code === "hgt") this.height = value;
        if (code === "hcl") this.hairColor = value;
        if (code === "ecl") this.eyeColor = value;
        if (code === "pid") this.passportID = value;
        if (code === "cid") this.countryID = value;
    }

    isValid(): boolean {
        if (!Validator.birthYear(this.birthYear)) return false;
        if (!Validator.issueYear(this.issueYear)) return false;
        if (!Validator.expirationYear(this.expirationYear)) return false;
        if (!Validator.height(this.height)) return false;
        if (!Validator.hairColor(this.hairColor)) return false;
        if (!Validator.eyeColor(this.eyeColor)) return false;
        if (!Validator.passportID(this.passportID)) return false;

        return true;
    }
}

const input: string = await Deno.readTextFile("input");
const data: string[] = input.split("\n");
const result: Passport[] = [];
let tempPass = new Passport();

for (const line of data) {
    if (line === "") {
        result.push(tempPass);
        tempPass = new Passport();
    }

    const lineData = line.split(" ");

    lineData.forEach((pair) => {
        const [code, value] = pair.split(":");
        tempPass.insertByCode(code, value);
    });
}

console.log("Result ", result.filter((p) => p.isValid()).length);
