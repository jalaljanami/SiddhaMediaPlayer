//
//  MediaPlayerView.swift
//  SiddhaMediaPlayer
//
//  Created by jalal on 11/16/24.
//

import SwiftUI
import AVKit

/// A SwiftUI view that integrates an audio player interface with a background video.
/// It handles user inactivity and audio playback using shared state managers.
struct MediaPlayerView: View {
    
    /// Shared instance of `InactivityTimerManager` to manage user inactivity events.
    @StateObject private var timerManager = InactivityTimerManager.shared
    
    /// Shared instance of `AudioPlayerManager` to manage audio playback controls.
    @StateObject private var audioPlayerManager = AudioPlayerManager.shared
    
    var body: some View {
        
        ZStack {
            /// Displays a background video for the media player.
            /// User interactions pass through due to `.allowsHitTesting(false)`.
            BackgroundVideoPlayer()
                .allowsHitTesting(false)

            /// Displays the audio player interface.
            /// Dependencies are injected using environment objects for state sharing.
            AudioPlayerView()
                .environmentObject(timerManager)
                .environmentObject(audioPlayerManager)
        }
    }
}

#Preview {
    MediaPlayerView()
        .environmentObject(AudioPlayerManager.shared)
}
