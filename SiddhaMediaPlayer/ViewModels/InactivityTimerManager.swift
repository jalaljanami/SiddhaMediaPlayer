//
//  InactivityTimerManager.swift
//  SiddhaMediaPlayer
//
//  Created by jalal on 11/18/24.
//

import Foundation
import Combine

/// Manages inactivity detection based on user interaction and a predefined threshold.
class InactivityTimerManager: ObservableObject {
    
    // MARK: - Shared Instance
    static let shared = InactivityTimerManager()
    
    // MARK: - Published Properties
    /// Indicates whether the system is inactive.
    @Published private(set) var isInactive: Bool = false
    
    // MARK: - Configuration
    private let inactivityThreshold: TimeInterval
    
    // MARK: - Internal State
    private var lastInteractionTime: Date
    private var timerSubscription: AnyCancellable?
    
    // MARK: - Initializers
    private init(threshold: TimeInterval = 5.0) { // Default to 5 seconds
        self.inactivityThreshold = threshold
        self.lastInteractionTime = Date()
        startInactivityMonitor()
    }
    
    // MARK: - Public Methods
    /// Resets the inactivity timer, typically called when the user interacts.
    func resetTimer() {
        lastInteractionTime = Date()
        if isInactive {
            isInactive = false
        }
    }
    
    // MARK: - Private Methods
    /// Starts a periodic monitor to check for inactivity.
    private func startInactivityMonitor() {
        timerSubscription = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.evaluateInactivity()
            }
    }
    
    /// Evaluates if the inactivity threshold has been reached.
    private func evaluateInactivity() {
        let elapsedTime = Date().timeIntervalSince(lastInteractionTime)
        if elapsedTime >= inactivityThreshold {
            isInactive = true
        }
    }
}
