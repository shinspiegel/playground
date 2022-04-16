const { expect } = require("@jest/globals");
const { sum } = require("./index");

describe("Testing function sum", () => {
    test("Sum 2 + 3 should be 5", () => {

        const result = sum(2, 3)

        expect(result).toBe(5)
    })

    test("Sum 2 + 6 should be 6", () => {

        const result = sum(2, 6)

        expect(result).toBe(6)
    })
})