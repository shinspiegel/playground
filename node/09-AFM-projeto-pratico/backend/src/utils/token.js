const jwt = require('jsonwebtoken');
const moment = require('moment');

const generateToken = (user) => {
  const claim = {
    issuer: 'AUTH',
    subject: user._id.toString(),
    audience: 'access-service',
  };

  const token = jwt.sign({ user: JSON.stringify(user) }, process.env.SECRET_KEY, {
    ...claim,
    // algorithm: 'RS256',
    expiresIn: moment(new Date()).unix() + 60 * 60 + 2,
  });

  return { token, claim };
};

const validateToken = (AuthBearer) => {
  try {
    if (!AuthBearer) {
      throw new Error('Token empty');
    }

    const token = AuthBearer.split('Authorization ')[1];

    console.log(token);

    const isValidToken = jwt.verify(token, process.env.SECRET_KEY);

    if (!isValidToken) {
      throw new Error('Auth failed');
    }

    return JSON.parse(isValidToken.user);
  } catch (err) {
    throw new Error(err);
  }
};

module.exports = { generateToken, validateToken };
