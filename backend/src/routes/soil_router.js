import express from 'express';

import { PostSoilData } from '../controllers/soil_controller.js';

const router = express.Router();

router.post("/soil-data", PostSoilData);

export default router;