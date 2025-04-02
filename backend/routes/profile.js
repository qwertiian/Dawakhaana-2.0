const express = require('express');
const router = express.Router();
const authMiddleware = require('../middleware/auth');
const { supabase } = require('../config/supabase');

router.get('/', authMiddleware, async (req, res) => {
  try {
    const { data, error } = await supabase
        .from('profiles')
        .select('name, phone, created_at, last_login')
        .eq('id', req.user.id)
        .single();

    if (error) throw error;
    res.json(data);
  } catch (err) {
    res.status(500).json({ error: 'Database error' });
  }
});

module.exports = router;