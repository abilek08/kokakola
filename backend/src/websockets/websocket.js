import SoilWEBSocket from "./soil_ws.js";

function WebSocketRouter(ws, req) {
    console.log('Connected!');
    
    ws.once('message', (message) => {
        console.log(`Menerima pesan: ${message}`);
    });

    ws.on('close', () => {
        console.log('Klien terputus');
    });

    ws.on('error', (error) => {
        console.error('Terjadi error WebSocket:', error);
    });

    SoilWEBSocket(ws, req);
}

export default WebSocketRouter;