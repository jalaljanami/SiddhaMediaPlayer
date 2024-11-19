//
//  AudioPlayerView.swift
//  SiddhaMediaPlayer
//
//  Created by jalal on 11/17/24.
//

import SwiftUI

/// A view that provides a user interface for controlling audio playback and displays meditation details.
struct AudioPlayerView: View {
    
    // MARK: - Environment Objects
    /// Manages user inactivity and updates the hidden state of controls.
    @EnvironmentObject var timerManager: InactivityTimerManager
    
    /// Handles audio playback, including loading and managing the audio file.
    @EnvironmentObject var audioPlayerManager: AudioPlayerManager
    
    // MARK: - State Variables
    /// Indicates whether the playback controls are hidden.
    @State private var isControllersHidden = false
    
    /// Holds information about the current meditation track.
    @State private var meditationTrack = Constants.Model.meditation
    
    var body: some View {
        ZStack {
            /// Background gradient for aesthetic appeal and improved readability.
            LinearGradient(colors: [.black, .black.opacity(0.5),.clear], startPoint: .bottom, endPoint: .init(x: 0.5, y: 0.4))
                .edgesIgnoringSafeArea(.all)
                .opacity(isControllersHidden ? 0 : 1)
            
            /// Main content layout
            VStack(spacing: 16) {
                Spacer()
                
                /// Display track title and author
                HStack {
                    VStack(alignment: .leading) {
                        Text(audioPlayerManager.isUnguided ? "Unguided" : meditationTrack.name)
                            .lineLimit(2)
                            .font(.title.weight(.bold))
                            .foregroundStyle(.white)
                        
                        Text(audioPlayerManager.isUnguided ? "End of Class" : meditationTrack.arthur)
                            .font(.subheadline)
                            .foregroundStyle(.white)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .opacity(isControllersHidden ? 0 : 1)
                    
                    /// Skip button for advancing playback
                    if audioPlayerManager.isUnguided {
                        SkipButton(action: timerManager.resetTimer)
                            .opacity(isControllersHidden ? 0 : 1)
                    }
                }
                
                /// Progress bar for the audio player
                PlayerProgress()
                    .frame(height: 40)
                    .opacity(isControllersHidden ? 0 : 1)
                  
                /// Playback controls
                AudioPlayerControllers(isControllersHidden: $isControllersHidden, meditationTrack: meditationTrack)
                    .environmentObject(audioPlayerManager)
                    .environmentObject(timerManager)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 32)

            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .onAppear {
            /// Load the audio file when the view appears
            audioPlayerManager.loadAudioFile(named: meditationTrack.filename)
            isControllersHidden = timerManager.isInactive
        }
        .onReceive(timerManager.$isInactive) { isInactive in
            /// Update visibility of controls based on inactivity state
            withAnimation {
                isControllersHidden = isInactive
            }
        }
        .onTapGesture {
            /// Reset inactivity timer when the view is tapped
            timerManager.resetTimer()
        }
    }
}


#Preview {
    ZStack {
        Color.black
        AudioPlayerView()
            .environmentObject(AudioPlayerManager.shared)
            .environmentObject(InactivityTimerManager.shared)
    }
}
