import express from 'express';

import SoilRouter from './soil_router.js';

const router = express.Router();

router.use("/sensor", SoilRouter);

export default router;