module.exports = {
  env: {
    browser: true,
    es2021: true,
  },
  extends: 'airbnb-base',
  plugins: ['ban-class'],
  overrides: [],
  parserOptions: {
    ecmaVersion: 'latest',
    sourceType: 'module',
  },
  rules: {
    'ban-class/ban-class': ['error', { banned: ['Date'] }],
    'no-console': 'off',
  },
};
