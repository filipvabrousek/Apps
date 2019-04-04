func getHeartBPMData(characteristic: CBCharacteristic, error: Error?) {
        if error != nil { print(" getHeartBPMData:: \(error!)") }
        guard let data = characteristic.value else { return }
        
        let count = data.count / MemoryLayout<UInt8>.size
        var array = [UInt8](repeating: 0, count: count)
        data.copyBytes(to: &array, count:count * MemoryLayout<UInt8>.size)
        
        if ((array[0] & 0x01) == 0) {
            let bpm = array[1]
            let bpmInt = Int(bpm)
            let hr = HeartRate(BPM: bpmInt, intensity: self.getHRIntensity(hr: bpmInt))
            self.update?(hr)
        }
        
    }
    
    
    // https://github.com/gazolla/HeartMonitor/blob/master/HeartMonitor/HeartRateMonitor.swift
