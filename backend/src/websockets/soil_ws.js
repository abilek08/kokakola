import expressWs from "express-ws";
import SoilData from "../utils/soil_event.js";

/**
 * 
 * @param {expressWs.WebsocketMethod} ws 
 * @param {Express.Request} req 
 */
function SoilWEBSocket(ws, req) {
    const ev = SoilData.ev;

    const soilDataListener = (data) => {
        ws.send(JSON.stringify(data));
    };
    ev.on('soilData', soilDataListener);
    ws.on("message", (msg) => {
        msg = msg.toString();
        console.log("Received message:", msg);
        if (msg === "getHistory") {
            const history = SoilData.getData();
            ws.send(JSON.stringify({ history }));
        }
        if (msg === "ping") {
            ws.send(JSON.stringify({ type: "pong" }));
        }
    });
}


export default SoilWEBSocket;