const jwt = require('jsonwebtoken');
const { jwtSecret, jwtExpiresIn } = require('./config');

module.exports = {
  sign: (payload) => jwt.sign(payload, jwtSecret, { expiresIn: jwtExpiresIn }),
  verify: (token) => jwt.verify(token, jwtSecret)
};