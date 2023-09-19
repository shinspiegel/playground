const path = require('path');

module.exports = {
  process(src, filename, config, options) {
    return `modul.exports = ${JSON.stringify(path.basename(filename))};`;
  },
};
