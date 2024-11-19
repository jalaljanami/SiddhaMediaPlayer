//
//  PlayerProgress.swift
//  SiddhaMediaPlayer
//
//  Created by jalal on 11/17/24.
//

import SwiftUI

/// A SwiftUI view displaying an interactive progress bar for audio playback.
/// - Supports drag gestures for seeking.
/// - Optimized for smooth animations and large screen sizes.
/// - Customizable properties for scalable integration in different UI designs.
struct PlayerProgress: View {
    
    // MARK: - Environment Objects
    @EnvironmentObject var timerManager: InactivityTimerManager
    @EnvironmentObject var audioPlayerManager: AudioPlayerManager
    
    // MARK: - State Variables
    @State private var progress: Double = 0.01 // Tracks playback progress (0.0 to 1.0).
    @State private var barThickness: CGFloat = 10 // Progress bar thickness, dynamically adjusted during interaction.
    @State private var currentOpacity: Double = 0.2 // Opacity for the draggable handle.

    // MARK: - Computed Variable
    var progressBarWidth: CGFloat {
        let calculatedWidth = Constants.UI.paddedScreenWidth * CGFloat(progress)
        return max(1, min(calculatedWidth, Constants.UI.paddedScreenWidth - Constants.UI.smallRelativeToScreenWidth - Constants.UI.smallPadding))
    }

    // MARK: - View Body
    var body: some View {
        VStack {
            GeometryReader { geometry in
                HStack {
                    // Progress Bar Background
                    ZStack(alignment: .leading) {
                        // Background track
                        Capsule()
                            .fill(.white.opacity(0.2))
                            .frame(height: 20)
                        
                        // Progress Indicator
                        Rectangle()
                            .fill((barThickness == 20) ? Color.white : Color.white.opacity(0.7))
                            .frame(width: progressBarWidth, height: barThickness)
                            .clipShape(.rect(cornerRadius: 20))
                    }
                    .frame(height: 20)
                    
                    .mask {
                        RoundedRectangle(cornerRadius: 40)
                            .frame(height: barThickness)
                            .clipped()
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                handleDragChange(value, in: geometry.size.width)
                            }
                            .onEnded { _ in
                                finalizeSeek()
                            }
                    )
                    
                    // Unguided Status Indicator
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: Constants.UI.smallRelativeToScreenWidth, height: barThickness)
                        .foregroundStyle(.white.opacity(currentOpacity))
                        .onReceive(audioPlayerManager.unguidedtimer) { _ in
                            handleUnguidedState()
                        }
                        .animation(.easeInOut, value: currentOpacity)
                }
            }
            
            // Time Labels
            HStack {
                // Current playback time
                Text(timeString(for: audioPlayerManager.currentTime))
                    .font(.caption)
                    .foregroundColor(.white)
                
                Spacer()
                
                // Total time or Unguided status
                Text(audioPlayerManager.isUnguided ? "+\(timeString(for: audioPlayerManager.unguidedTime))" : timeString(for: audioPlayerManager.currentTime - audioPlayerManager.duration))
                    .font(.caption)
                    .foregroundColor(audioPlayerManager.isUnguided ? .green : .white)
            }
        }
        .onReceive(audioPlayerManager.$updateProgreess) { currentTime in
            progress = currentTime
        }
    }
    
    // MARK: - Helpers

    /// Updates the progress as the user drags the handle.
    private func handleDragChange(_ value: DragGesture.Value, in width: CGFloat) {
        let newProgress = min(max(0, (value.location.x) / width * 1.1), 1)
        withAnimation {
            progress = newProgress
            barThickness = 16
        }
        timerManager.resetTimer()
    }
    
    /// Finalizes the seek operation and resets the bar thickness.
    private func finalizeSeek() {
        withAnimation(.easeInOut(duration: 0.15)) {
            barThickness = 10
        }
        timerManager.resetTimer()
        audioPlayerManager.seek(to: progress * audioPlayerManager.duration)
    }
    
    /// Toggles the opacity of the handle when the Unguided timer is active.
    private func handleUnguidedState() {
        if audioPlayerManager.isUnguided {
            toggleOpacity()
        }
    }
    
    /// Toggles the opacity of the unguided indicator.
    private func toggleOpacity() {
        currentOpacity = currentOpacity == 1.0 ? 0.2 : 1.0
    }
}

#Preview {
    ZStack {
        Color.gray
        PlayerProgress()
            .environmentObject(AudioPlayerManager.shared)
            .environmentObject(InactivityTimerManager.shared)
    }
}
