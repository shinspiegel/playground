/* eslint-disable global-require */
/* eslint-disable import/no-extraneous-dependencies */

module.exports = {
  plugins: {
    "postcss-sorting": {
      order: ["custom-properties", "dollar-variables", "declarations", "at-rules", "rules"],
      "properties-order": "alphabetical",
      "unspecified-properties-position": "bottom",
    },
  },
};
