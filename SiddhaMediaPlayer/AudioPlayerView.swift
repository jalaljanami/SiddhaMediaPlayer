//
//  AudioPlayerView.swift
//  SiddhaMediaPlayer
//
//  Created by jalal on 11/17/24.
//

import SwiftUI
import AVFoundation

class AudioPlayerManager: ObservableObject {
    
    @Published var currentTime: TimeInterval = 0
    @Published var duration: TimeInterval = 0
    
    private var looping: Bool = false
    
    private var timer: Timer?
    private var player: AVAudioPlayer?
    
    init(audioFileName: String) {
        if let url = Bundle.main.url(forResource: audioFileName, withExtension: "mp3") {
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.prepareToPlay()
                duration = player?.duration ?? 0
            } catch {
                print("Error loading audio file: \(audioFileName) - \(error.localizedDescription)")
            }
        } else {
            print("File not found: \(audioFileName)")
        }
    }
    
    func play() {
        player?.play()
        startTimer()
    }
    
    func pause() {
        player?.pause()
        stopTimer()
    }
    
    func stop() {
        player?.stop()
        stopTimer()
        currentTime = 0
    }
    
    func seek(to time: TimeInterval) {
        player?.currentTime = time
        currentTime = time
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.currentTime = self.player?.currentTime ?? 0
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

struct AudioPlayerView: View {
    @StateObject private var audioManager = AudioPlayerManager(audioFileName: "Improving Creativity-Mychal-15m-895s-v2")
    @StateObject private var NoiseAudioManager = AudioPlayerManager(audioFileName: "white noise -30 copy")
    
    @Binding var isPlaying : Bool
    
    @State private var isNoisePlaying = false
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading) {
                Text("Title")
                    .font(.title).bold()
                    .foregroundStyle(.white)

                Text("Description")
                    .font(.subheadline)
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
            
            PlayerProgressView(audioManager: audioManager)
                .frame(height: 50)
             
            HStack {
                Spacer(minLength: 32)

                Button {
                    
                } label: {
                    Image(uiImage: .add)
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                }

                Button {
                    if isPlaying {
                        audioManager.stop()
                        NoiseAudioManager.stop()
                        isPlaying.toggle()
                    } else {
                        audioManager.play()
                        NoiseAudioManager.play()
                        isPlaying.toggle()
                    }
                } label: {

                    Text(isPlaying ? "Stop All" : "Play All")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                        .background(isPlaying ? Color.red : Color.green)
                        .cornerRadius(10)
                }

                Button {
                    //
                } label: {
                    Image(systemName: "15.arrow.trianglehead.clockwise")

                        .foregroundStyle(.white)
                        .aspectRatio(1, contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                }
                Spacer(minLength: 32)
            }
            .frame(maxWidth: .infinity)
            .padding(32)
            
            
            Button(action: {
                if isNoisePlaying {
                    NoiseAudioManager.stop()
                    isNoisePlaying.toggle()
                } else if isPlaying {
                    NoiseAudioManager.play()
                    isNoisePlaying.toggle()
                }
                
            }) {
                Text(isNoisePlaying ? "Stop Noise" : "Play Noise")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(isNoisePlaying ? Color.red : Color.green)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
    
    // Format time as MM:SS
    private func formattedTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    AudioPlayerView(isPlaying: .constant(true))
}
