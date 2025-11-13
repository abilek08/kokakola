import express from "express";
import SoilData from "../utils/soil_event.js";

/**
 * 
 * @param {express.Request} req 
 * @param {express.Response} res 
 */
async function PostSoilData(req, res) {
    const {
        humidity,
    } = req.body;
    console.log("Received soil data:", { humidity });

    if (!humidity) {
        return res.status(400).json({ error: "Missing humidity field" });
    }

    SoilData.setData({
        humidity
    })

    res.sendStatus(200);
}

export { PostSoilData };