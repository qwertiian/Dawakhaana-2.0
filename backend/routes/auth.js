const express = require('express');
const router = express.Router();
const { supabase } = require('../config/supabase');
const { sign } = require('../config/jwt');
const rateLimiter = require('../middleware/rateLimit');

// Send OTP
router.post('/send-otp', rateLimiter, async (req, res) => {
  const { phone,mode } = req.body;

  if (!phone?.match(/^\+?\d{10,15}$/)) {
    return res.status(400).json({
      error: 'Invalid phone format. Include country code (e.g., +14155552671)',
    });
  }

  try {

    const { data: user, error: profileError } = await supabase
        .from('profiles')
        .select('id')
        .eq('phone', phone)
        .single();

// Handle different behavior based on mode
    if (mode === 'login') {
      if (profileError || !user) {
        return res.status(404).json({
          error: 'User not registered. Please sign up first.',
        });
      }
    } else if (mode === 'register') {
      if (user) {
        return res.status(409).json({
          error: 'Phone number already registered. Please log in.',
        });
      }
    }

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

// Verify OTP and insert user into profiles table
router.post('/verify-otp', rateLimiter, async (req, res) => {
  const { phone, otp, name } = req.body;

  if (!phone?.match(/^\+?\d{10,15}$/)) {
    return res.status(400).json({ error: 'Invalid phone format.' });
  }

  if (!otp?.match(/^\d{6}$/)) {
    return res.status(400).json({ error: 'OTP must be 6 digits' });
  }

  try {
    const { data, error } = await supabase.auth.verifyOtp({
      phone,
      token: otp,
      type: 'sms',
    });

    if (error) throw error;

    const userId = data.user.id;

    // Check if user already exists in 'profiles'
    const { data: existingUser, error: fetchError } = await supabase
        .from('profiles')
        .select('id')
        .eq('id', userId)
        .single();

    if (fetchError && fetchError.code !== 'PGRST116') {
      throw fetchError;
    }

    if (!existingUser) {
      const { error: insertError } = await supabase.from('profiles').insert([
        {
          id: userId,
          name: name || null,
          phone,
        },
      ]);
      if (insertError) throw insertError;
      console.log('✅ New user inserted into profiles');
    } else {
      console.log('ℹ️ User already exists in profiles');
    }

    const token = sign({ sub: userId, phone });

    res.json({
      success: true,
      token,
      user: { id: userId },
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