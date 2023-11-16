//
//  Download.swift
//  DLTime
//
//  Created by KaayZenn on 13/11/2023.
//
//

import Foundation
import SwiftData

@Model public class Download: Identifiable {
    public var id: UUID = UUID()
    var title: String = ""
    var speed: Double = 0.0
    var size: Double = 0.0
    var variation: Double = 0.0
    var date: Date = Date.now
    
    init(title: String, speed: Double, size: Double, variation: Double, date: Date) {
        self.title = title
        self.speed = speed
        self.size = size
        self.variation = variation
        self.date = date
    }
}

extension Download {
    
    var normalTimeOfDownloadInSeconds: Double {
        let fileSizeMB = size * 1024
        return fileSizeMB / speed
    }
    
    var shortestTimeOfDownloadInSeconds: Double {
        if variation != 0 {
            let maxSpeed = speed + variation
            let fileSizeMB = size * 1024
            return fileSizeMB / maxSpeed
        } else {
            return 0
        }
    }
    
    var longestTimeOfDownloadInSeconds: Double {
        if variation != 0 {
            let maxSpeed = speed - variation
            let fileSizeMB = size * 1024
            return fileSizeMB / maxSpeed
        } else {
            return 0
        }
    }
    
}
