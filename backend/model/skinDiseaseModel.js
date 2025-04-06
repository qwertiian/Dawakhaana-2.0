const tf = require('@tensorflow/tfjs-node');
const path = require('path');

let model;

const loadModel = async () => {
    try {
        model = await tf.loadLayersModel(`file://${path.join(__dirname, './model.json')}`);
        console.log("✅ Skin disease model loaded successfully.");
    } catch (error) {
        console.error("❌ Failed to load skin disease model:", error);
        throw error;
    }
};

const predictDisease = async (imageBuffer) => {
    if (!model) {
        await loadModel();
    }
    const tensor = tf.node.decodeImage(imageBuffer, 3)
        .resizeNearestNeighbor([224, 224])
        .toFloat()
        .div(255.0)
        .expandDims();
    const prediction = model.predict(tensor);
    const predictionArray = prediction.arraySync()[0];
    const maxIndex = predictionArray.indexOf(Math.max(...predictionArray));
    const confidence = (predictionArray[maxIndex] * 100).toFixed(2);
    return { classIndex: maxIndex, confidence };
};

module.exports = { loadModel, predictDisease };
