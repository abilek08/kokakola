import { time } from 'console';
import event from 'events';

const soilEvent = new event.EventEmitter();
const soilData = [];

class SoilData {
    constructor() {}

    static setData(data) {
        soilData.push({
            time: new Date().toISOString(),
            ...data
        })
        soilEvent.emit('soilData', data);
    }
    static getData() {
        return soilData
    }
    static get ev() {
        return soilEvent;
    }
}

export default SoilData;