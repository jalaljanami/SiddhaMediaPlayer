//
//  AudioPlayerControllers.swift
//  SiddhaMediaPlayer
//
//  Created by jalal on 11/19/24.
//

import SwiftUI

struct AudioPlayerControllers: View {
    
    @EnvironmentObject var timerManager: InactivityTimerManager
    @EnvironmentObject var audioPlayerManager: AudioPlayerManager
    
    @Binding var isControllersHidden : Bool
    @State var meditationTrack : Meditation
    
    var body: some View {
        HStack {
            Spacer(minLength: 8)
            
            // NoiseMute
            Button {
                timerManager.resetTimer()
                audioPlayerManager.toggleMuteWhiteNoise()

            } label: {
                Image(systemName: audioPlayerManager.isWhiteNoiseMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, maxHeight: 24)
            }
            .buttonStyle(PressableButtonStyle())
            .opacity(isControllersHidden ? 0 : 1)
            
            // SeekBackword
            Button {
                timerManager.resetTimer()
                
                if audioPlayerManager.currentTime > 15 {
                    audioPlayerManager.seek(to: audioPlayerManager.currentTime - 15)
                } else {
                    audioPlayerManager.seek(to: 0)
                }
            } label: {
                Image(systemName: "15.arrow.trianglehead.counterclockwise")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, maxHeight: 30)
            }
            .opacity(isControllersHidden ? 0 : 1)
            
            // PlayPause
            Button {
                timerManager.resetTimer()
                
                if audioPlayerManager.isPlaying {
                    audioPlayerManager.pause()
                } else {
                    audioPlayerManager.play()
                }
            } label: {
                
                Image(audioPlayerManager.isPlaying ? .pauseCustom : .playCustom)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundStyle(isControllersHidden ? .white.opacity(0.3) : .white)
                    
                    .frame(maxWidth: .infinity, maxHeight: 90)
                    
                    .foregroundColor(.white)
            }
            .buttonStyle(PressableButtonStyle())
            
            // SeekForward
            Button {
                timerManager.resetTimer()
                
                if audioPlayerManager.currentTime + 15 < audioPlayerManager.duration {
                    audioPlayerManager.seek(to: audioPlayerManager.currentTime + 15)
                } else {
                    audioPlayerManager.seek(to: audioPlayerManager.duration)
                }
            } label: {
                Image(systemName: "15.arrow.trianglehead.clockwise")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, maxHeight: 30)
            }
            .buttonStyle(PressableButtonStyle())
            .opacity(isControllersHidden ? 0 : 1)
            
            Button {
                //
                timerManager.resetTimer()
                meditationTrack.toggleLike()
            } label: {
                Image(systemName: "heart.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(meditationTrack.isLiked ? .blue : .white)
                    .frame(maxWidth: .infinity, maxHeight: 24)
            }
            .buttonStyle(PressableButtonStyle())
            .opacity(isControllersHidden ? 0 : 1)
            
            Spacer(minLength: 8)
        }
    }
}

#Preview {
    AudioPlayerControllers(isControllersHidden: .constant(false), meditationTrack: Constants.Model.meditation)
        .environmentObject(AudioPlayerManager.shared)
        .environmentObject(InactivityTimerManager.shared)
}
