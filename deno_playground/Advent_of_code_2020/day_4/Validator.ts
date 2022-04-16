export default class Validator {
    static validateYear(
        value: number | undefined,
        digits: number,
        minYear: number,
        maxYear: number
    ) {
        if (!value) return false;
        if (String(value).length !== digits) return false;
        if (value < minYear) return false;
        if (value > maxYear) return false;
        return true;
    }

    static birthYear(value: number | undefined): boolean {
        return this.validateYear(value, 4, 1920, 2002);
    }

    static issueYear(value: number | undefined): boolean {
        return this.validateYear(value, 4, 2010, 2020);
    }

    static expirationYear(value: number | undefined): boolean {
        return this.validateYear(value, 4, 2020, 2030);
    }

    static height(value: string | undefined): boolean {
        if (!value) return false;

        const type: string = value.slice(-2);
        const number = Number(value.replace(/\D/g, ""));

        if (type !== "cm" && type !== "in") return false;

        if (type === "cm") {
            if (number < 150) return false;
            if (number > 193) return false;
        }

        if (type === "in") {
            if (number < 59) return false;
            if (number > 76) return false;
        }

        return true;
    }

    static passportID(value: string | undefined): boolean {
        if (!value) return false;
        if (value.length !== 9) return false;
        return true;
    }

    static hairColor(value: string | undefined): boolean {
        if (!value) return false;
        return /^#([0-9A-F]{6}){1,2}$/i.test(value);
    }

    static eyeColor(value: string | undefined): boolean {
        if (!value) return false;

        const possibleColors = [
            "amb",
            "blu",
            "brn",
            "gry",
            "grn",
            "hzl",
            "oth",
        ];

        return possibleColors.includes(value);
    }
}
