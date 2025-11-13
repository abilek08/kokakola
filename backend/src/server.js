import express from "express"
import expressWs from "express-ws";

const app = express();
expressWs(app);
app.use(express.json());

app.get("/", (req, res) => {
    res.send("Hello, World!");
});

import WebSocketRouter from "./websockets/websocket.js";
app.ws('/ws', WebSocketRouter);

// app.use(function (req, res, next) {
//     res.status(404).send("Sorry, can't find that!");
// });

export default app;