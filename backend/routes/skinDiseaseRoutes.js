const express = require('express');
const multer = require('multer');
const fs = require('fs');
const path = require('path');
const { predictDisease } = require('../model/skinDiseaseModel');

const router = express.Router();
const upload = multer({ dest: 'uploads/' });

const classLabels = [
    'BA-cellulitis',
    'BA-impetigo',
    'FU-athlete-foot',
    'FU-nail-fungus',
    'FU-ringworm',
    'PA-cutaneous-larva-migrans',
    'VI-chickenpox',
    'VI-shingles'
];

router.post('/predict', upload.single('file'), async (req, res) => {
    try {
        if (!req.file) {
            return res.status(400).json({ error: "No file uploaded" });
        }

        const imagePath = req.file.path;
        const imageBuffer = fs.readFileSync(imagePath);

        // Ensure predictDisease returns an index within the range of classLabels
        const { classIndex, confidence } = await predictDisease(imageBuffer);

        // Validate classIndex to prevent out-of-bounds errors
        if (classIndex < 0 || classIndex >= classLabels.length) {
            throw new Error("Invalid class index returned from prediction model.");
        }

        fs.unlinkSync(imagePath); // Clean up the uploaded image

        res.json({
            disease: classLabels[classIndex],
            confidence: `${confidence}%`
        });
    } catch (error) {
        console.error("Prediction error:", error);
        res.status(500).json({ error: "Prediction failed", details: error.message });
    }
});

module.exports = router;
