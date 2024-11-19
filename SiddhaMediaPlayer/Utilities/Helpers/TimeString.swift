//
//  TimeString.swift
//  SiddhaMediaPlayer
//
//  Created by jalal on 11/18/24.
//

import Foundation

// Helper: Format time
public func timeString(for seconds: Double) -> String {
    let isNegative = seconds < 0
    let absoluteSeconds = abs(seconds)
    let minutes = Int(absoluteSeconds) / 60
    let seconds = Int(absoluteSeconds) % 60

    return String(format: "%@%d:%02d", isNegative ? "-" : "", minutes, seconds)
}
