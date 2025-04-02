const { supabase } = require('../config/supabase');
const { verify } = require('../config/jwt');

module.exports = async (req, res, next) => {
  const token = req.headers.authorization?.split(' ')[1] || req.cookies?.token;

  if (!token) {
    return res.status(401).json({ error: 'Authentication required' });
  }

  try {
    const decoded = verify(token);
    const { data: user, error } = await supabase.auth.admin.getUserById(decoded.sub);

    if (error || !user) {
      return res.status(401).json({ error: 'Invalid user' });
    }

    req.user = {
      id: decoded.sub,
      phone: user.user.phone,
      role: decoded.role || 'user'
    };

    next();
  } catch (err) {
    res.status(401).json({ error: 'Invalid token' });
  }
};