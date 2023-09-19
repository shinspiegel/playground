const crypto = require('crypto');

const generateHash = (password, preSalt) => {
  const algorithm = 'sha256';
  const salt = preSalt || crypto.randomBytes(Math.ceil(8)).toString('hex').slice(0, 16);
  const hash = crypto.createHmac(algorithm, salt);

  hash.update(password);

  return [algorithm, salt, hash.digest('hex')].join('$');
};

const validateHash = (hashedPassword, unhashedPassword) => {
  const [algorithm, salt, hash] = hashedPassword.split('$');
  const valueHashed = generateHash(unhashedPassword, salt);
  return hashedPassword === valueHashed;
};

module.exports = { generateHash, validateHash };
