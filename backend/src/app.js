import APIRouter from "./routes/api_router.js";
import SoilRouter from "./routes/soil_router.js";
import app from "./server.js";


const PORT = process.env.PORT || 3000;


//app.use("/api", APIRouter);

app.post("/soil-data", SoilRouter);

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});