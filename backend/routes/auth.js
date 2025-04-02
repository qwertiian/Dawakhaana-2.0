const express = require('express');
const router = express.Router();
const { supabase } = require('../config/supabase');
const { sign } = require('../config/jwt');
const rateLimiter = require('../middleware/rateLimit');

// Endpoint to initiate phone sign-in
router.post('/send-otp', rateLimiter, async (req, res) => {
  const { phone } = req.body;

  // Validate phone number format
  if (!phone?.match(/^\+?\d{10,15}$/)) {
    return res.status(400).json({
      error: 'Invalid phone format. Include country code (e.g., +14155552671)',
    });
  }

  try {
    // Send OTP to the provided phone number
    const { error } = await supabase.auth.signInWithOtp({ phone });
    if (error) throw error;
    res.json({ success: true, message: 'OTP sent successfully' });
  } catch (error) {
    console.error('Error sending OTP:', error);
    res.status(500).json({
      error: 'Failed to send OTP',
      details: error.message,
    });
  }
});

// Endpoint to verify the received OTP
router.post('/verify-otp', rateLimiter, async (req, res) => {
  const { phone, otp } = req.body;

  // Validate inputs
  if (!phone?.match(/^\+?\d{10,15}$/)) {
    return res.status(400).json({
      error: 'Invalid phone format. Include country code (e.g., +14155552671)',
    });
  }

  if (!otp?.match(/^\d{6}$/)) {
    return res.status(400).json({ error: 'OTP must be 6 digits' });
  }

  try {
    // Verify the OTP
    const { data, error } = await supabase.auth.verifyOtp({
      phone,
      token: otp,
      type: 'sms',
    });

    if (error) throw error;

    // Generate JWT for authenticated user
    const token = sign({
      sub: data.user.id,
      phone,
    });

    res.json({
      success: true,
      token,
      user: { id: data.user.id },
    });
  } catch (error) {
    console.error('OTP Verification Error:', error);
    res.status(401).json({
      error: 'OTP verification failed',
      details: error.message,
    });
  }
});

module.exports = router;
