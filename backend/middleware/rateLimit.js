const rateLimit = require('express-rate-limit');
const { OTP_LIMIT, OTP_WINDOW_MINUTES } = require('../config/config');

module.exports = rateLimit({
  windowMs: OTP_WINDOW_MINUTES * 60 * 1000,
  max: OTP_LIMIT,
  message: { error: 'Too many requests' },
  standardHeaders: true,
  legacyHeaders: false
});