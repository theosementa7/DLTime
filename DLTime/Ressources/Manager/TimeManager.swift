//
//  TimeManager.swift
//  DLTime
//
//  Created by KaayZenn on 16/11/2023.
//

import Foundation

class TimeManager {
    
    func formattedDownloadTime(timeInSeconds: Double) -> String {
        let totalSeconds = timeInSeconds
        let hours = Int(totalSeconds) / 3600
        let minutes = Int(totalSeconds) / 60 % 60
        let seconds = Int(totalSeconds) % 60
        
        return String(format: "%02dh %02dm %02ds", hours, minutes, seconds)
    }
    
}
