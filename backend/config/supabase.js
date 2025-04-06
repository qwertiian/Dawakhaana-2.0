const { createClient } = require('@supabase/supabase-js');

// Verify environment variables
if (!process.env.SUPABASE_URL || !process.env.SUPABASE_SERVICE_ROLE_KEY) {
    throw new Error('Supabase credentials missing in .env');
}

const supabase = createClient(
    process.env.SUPABASE_URL,
    process.env.SUPABASE_SERVICE_ROLE_KEY,
    {
        auth: {
            autoRefreshToken: false,
            persistSession: false,
            detectSessionInUrl: false
        }
    }
);

// Test connection immediately
supabase.auth.admin.listUsers()
    .then(() => console.log('✅ Supabase connected'))
    .catch(err => console.error('❌ Supabase connection failed:', err.message));

module.exports = { supabase };  // Export as named export