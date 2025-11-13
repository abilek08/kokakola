// import WebSocket from 'ws';

// const ws = new WebSocket('ws://localhost:3000/ws');

// ws.on('open', function open() {
//     console.log('WebSocket connection opened');
//     //ws.send('getHistory');
//     ws.send('ping');
// });

// ws.on('message', function message(data) {
//     console.log('Received:', data);
// });

// ws.on('close', function close() {
//     console.log('WebSocket connection closed');
// });

// ws.on('error', function error(err) {
//     console.error('WebSocket error:', err);
// });

// setInterval(() => {
//     ws.send('ping');
// }, 10000);

import axios from 'axios';

async function sendSoilData(humidity) {
    try {
        const response = await axios.post('http://localhost:3000/soil-data', {
            humidity: humidity
        });
        console.log('Soil data sent successfully:', response.status);
    } catch (error) {
        console.error('Error sending soil data:', error);
    }
}

setInterval(() => {
    const simulatedHumidity = Math.floor(Math.random() * 101); // Simulate humidity between 0-100%
    sendSoilData(simulatedHumidity);
}, 1000);