require('dotenv').config();

const validateConfig = () => {
    const requiredVars = [
        'SUPABASE_URL',
        'SUPABASE_SERVICE_ROLE_KEY',
        'JWT_SECRET'
    ];

    requiredVars.forEach(varName => {
        if (!process.env[varName]) {
            throw new Error(`Missing required env var: ${varName}`);
        }
    });
};

module.exports = {
    supabaseUrl: process.env.SUPABASE_URL,
    supabaseKey: process.env.SUPABASE_SERVICE_ROLE_KEY,
    jwtSecret: process.env.JWT_SECRET,
    jwtExpiresIn: process.env.JWT_EXPIRES_IN,
    port: process.env.PORT || 3000,
    validateConfig
};