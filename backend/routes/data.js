const express = require('express');
const router = express.Router();
const authMiddleware = require('../middleware/auth');
const { supabase } = require('../config/supabase');

router.get('/protected', authMiddleware, async (req, res) => {
  try {
    const { data, error } = await supabase
        .from('secure_data')
        .select('*')
        .eq('user_id', req.user.id);

    if (error) throw error;
    res.json(data);
  } catch (err) {
    res.status(500).json({ error: 'Database error' });
  }
});

module.exports = router;