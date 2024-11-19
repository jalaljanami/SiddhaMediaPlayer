//
//  AudioPlayerManager.swift
//  SiddhaMediaPlayer
//
//  Created by jalal on 11/18/24.
//

import SwiftUI
import AVFoundation

class AudioPlayerManager: NSObject, ObservableObject {
    
    @Published var currentTime: TimeInterval = 0
    @Published var duration: TimeInterval = 0
    @Published var updateProgreess: Double = 0.0
    @Published var isPlaying: Bool = false
    @Published var isLooping: Bool = false
    @Published var isWhiteNoiseMuted: Bool = false
    @Published var isUnguided: Bool = false
    @Published var unguidedTime: TimeInterval = 0
    @Published var unguidedtimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var whiteNoiseFilesName: String = "white noise -30 copy"
    private var timer: Timer?
    private var timerUnguided: Timer?
    private var player: AVAudioPlayer?
    private var whiteNoisePlayer: AVAudioPlayer?
    var originalDuration: TimeInterval = 0
    
    static let shared = AudioPlayerManager()
    
    private override init() {
        super.init()
        configureAudioSession()
        setupWhiteNoisePlayer()
     }
    
    // Configure the audio session to active even in SilentMode
    private func configureAudioSession() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default, options: [])
            try audioSession.setActive(true)
        } catch {
            print("Failed to set up audio session: \(error.localizedDescription)")
        }
    }
    
    // Set up the white noise player
    private func setupWhiteNoisePlayer() {
        if let url = Bundle.main.url(forResource: whiteNoiseFilesName, withExtension: "mp3") {
            do {
                whiteNoisePlayer = try AVAudioPlayer(contentsOf: url)
                whiteNoisePlayer?.prepareToPlay()
                whiteNoisePlayer?.play()
                whiteNoisePlayer?.numberOfLoops = -1
                whiteNoisePlayer?.volume = isWhiteNoiseMuted ? 0 : 1.0
            } catch {
                print("Error loading white noise file: \(error.localizedDescription)")
            }
        } else {
            print("White noise file not found: \(whiteNoiseFilesName)")
        }
    }
    
    // Method to load and play a specific audio file
    func loadAudioFile(named audioFileName: String) {
        stop() // Stop any currently playing audio
        
        if let url = Bundle.main.url(forResource: audioFileName, withExtension: "mp3") {
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.prepareToPlay()
                originalDuration = player?.duration ?? 0
                duration = (player?.duration ?? 0)
                player?.delegate = self // Set delegate to handle looping
            } catch {
                print("Error loading audio file: \(audioFileName) - \(error.localizedDescription)")
            }
        } else {
            print("File not found: \(audioFileName)")
        }
    }
    
    func playWhiteNoise() {
        whiteNoisePlayer?.play()
    }
    
    func toggleMuteWhiteNoise() {
        isWhiteNoiseMuted.toggle()
        whiteNoisePlayer?.volume = isWhiteNoiseMuted ? 0 : 1.0
    }
    
    func play() {
        guard let player = player else { return }
        player.play()
        isPlaying = true
        startTimer()
        stopUnguidedTimer()
        
    }
    
    func pause() {
        guard let player = player else { return }
        player.pause()
        isPlaying = false
        stopTimer()
    }
    
    func stop() {
        guard let player = player else { return }
        player.stop()
        isPlaying = false
        stopTimer()
        currentTime = 0
        player.currentTime = 0
    }
    
    func seek(to time: TimeInterval) {
        guard let player = player else { return }
        player.currentTime = time
        currentTime = time
        updateProgreess = currentTime / duration
    }
    
    func toggleLooping() {
        isLooping.toggle()
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

    private func startUnguidedTimer() {
        timerUnguided = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.unguidedTime += 1
            if self.unguidedTime >= 120 {
                self.stopUnguidedTimer()
            }
        }
    }
    
    private func stopUnguidedTimer() {
        timerUnguided?.invalidate()
        timerUnguided = nil
        isUnguided = false
    }
    
}

extension AudioPlayerManager: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        startUnguidedTimer()
        withAnimation {
            isUnguided = true
        }
        if isLooping {
            player.currentTime = 0
            player.play()
        } else {
            isPlaying = false
            stopTimer()
        }
    }
}
