const nextJest = require("next/jest");

const createJestConfig = nextJest({
  dir: "./",
});

const customJestConfig = {
  modulePathIgnorePatterns: [
    "<rootDir>/dist/",
    "<rootDir>/.next/",
    "<rootDir>/tests/",
    "<rootDir>/stores",
  ],
  moduleDirectories: ["node_modules", "<rootDir>/"],
  testEnvironment: "jest-environment-jsdom",
  coverageThreshold: { global: { lines: 70 } },
};

module.exports = createJestConfig(customJestConfig);
