//
//  TemperatureDataContainer.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 01.06.2023.
//

import Foundation

class TemperatureDataContainer: ObservableObject {
    @Published var data: [TemperatureData] = TemperatureDataContainer.getSampleData()
    
    public func updateData(_ data: [TemperatureData]) {
        self.data = data
    }
    
    class func getSampleData() -> [TemperatureData] {
        return [
            TemperatureData(id: "CPUE1", title: "CPU Efficiency core 1", floatValue: 43.1),
            TemperatureData(id: "CPUE2", title: "CPU Efficiency core 2", floatValue: 43.3),
            TemperatureData(id: "CPUP1", title: "CPU Performance core 1", floatValue: 45.2),
            TemperatureData(id: "CPUP2", title: "CPU Performance core 2", floatValue: 45.9),
            TemperatureData(id: "CPUP3", title: "CPU Performance core 3", floatValue: 47.3),
            TemperatureData(id: "CPUP4", title: "CPU Performance core 4", floatValue: 46.1),
            TemperatureData(id: "CPUP5", title: "CPU Performance core 5", floatValue: 46.8),
            TemperatureData(id: "CPUP6", title: "CPU Performance core 6", floatValue: 47.6)
        ]
    }
}
