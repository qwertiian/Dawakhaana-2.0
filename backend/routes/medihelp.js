// routes/medihelp.js
const express = require("express");
const router = express.Router();
const { GoogleGenerativeAI } = require("@google/generative-ai");
const translate = require("@iamtraction/google-translate");

const GEMINI_API_KEY = process.env.GEMINI_API_KEY;
if (!GEMINI_API_KEY) throw new Error("Missing GEMINI_API_KEY");

const genAI = new GoogleGenerativeAI(GEMINI_API_KEY);
const model = genAI.getGenerativeModel({ model: "gemini-1.5-pro-latest" });

const SUPPORTED_LANGUAGES = {
    english: "en",
    hindi: "hi",
    marathi: "mr",
};

const generateGeminiResponse = async (prompt) => {
    try {
        const result = await model.generateContent(prompt);
        return (await result.response).text();
    } catch (error) {
        console.error("Gemini Error:", error);
        return "I'm sorry, I couldn't generate a response.";
    }
};

router.post("/chat", async (req, res) => {
    const { symptoms, language } = req.body;

    if (!symptoms || !language) {
        return res.status(400).json({ error: "Missing symptoms or language" });
    }

    const normalizedLang = language.toLowerCase();
    if (!SUPPORTED_LANGUAGES[normalizedLang]) {
        return res.status(400).json({
            error: "Unsupported language. Please use English, Hindi, or Marathi.",
            supportedLanguages: Object.keys(SUPPORTED_LANGUAGES),
        });
    }

    const prompt = `
You are MediHelp, a rural health assistant bot. Follow these rules STRICTLY:

1. User reports: "${symptoms}"
2. DIRECTLY provide one of these responses:
   - If mild: Suggest 1-2 home remedies or OTC medicines
   - If serious: Clearly state "This seems serious" and advise seeing a doctor
3. NEVER ask follow-up questions
4. Keep response under 3 sentences
5. Format: "[MILD/SERIOUS] Your response here"
`;

    try {
        let responseText = await generateGeminiResponse(prompt);

        if (normalizedLang !== "english") {
            try {
                const translated = await translate(responseText, {
                    to: SUPPORTED_LANGUAGES[normalizedLang],
                    autoCorrect: true,
                });
                responseText = translated.text;
            } catch (translationError) {
                console.error("Translation failed:", translationError);
            }
        }

        res.json({ recommendation: responseText });
    } catch (error) {
        console.error("Error in /chat:", error);
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;
