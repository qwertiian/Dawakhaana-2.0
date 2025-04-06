require('dotenv').config();
const express = require('express');
const app = express();
const cors = require('cors');
const logger = require('./utils/logger');

// Import Routes
const authRoutes = require('./routes/auth');
const profileRoutes = require('./routes/profile');
const mediahelpRoutes = require('./routes/mediahelp'); // Import the medihelp router
const skinDiseaseRoutes = require('./routes/skinDiseaseRoutes');

// Middleware
app.set('trust proxy', true);
app.use(cors());
app.use(express.json());

// Health Check Route (Required for root URL)
app.get('/', (req, res) => {
    res.status(200).json({
        status: 'running',
        message: 'Dawakhaana backend service',
        timestamp: new Date().toISOString()
    });
});

// API Routes
app.use('/api/auth', authRoutes);
app.use('/api/profile', profileRoutes);
app.use('/api/mediahelp', mediahelpRoutes); // Mount the medihelp router
app.use('/api/skin', skinDiseaseRoutes);

// Handle 404
app.use((req, res) => {
    res.status(404).json({ error: 'Endpoint not found' });
});

// Error Handling
app.use((err, req, res, next) => {
    logger.error(err.stack);
    res.status(500).json({ error: 'Internal server error' });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    logger.info(`Server running on port ${PORT}`);
});