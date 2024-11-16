//
//  BackgroundVideoPlayer.swift
//  SiddhaMediaPlayer
//
//  Created by jalal on 11/16/24.
//

import SwiftUI
import AVKit

struct BackgroundVideoPlayer: View {
    
    @State private var isPlaying: Bool = true

    let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Class category mobile", ofType: "mp4")!))
        var body: some View {
            LoopingVideoView(player: player)
                .ignoresSafeArea()
                .onAppear {
                    player.play()
                }
                .onTapGesture {
                    if isPlaying {
                        player.pause()
                        isPlaying.toggle()
                    } else {
                        player.play()
                        isPlaying.toggle()
                    }
                }
        }
}

struct LoopingVideoView : UIViewControllerRepresentable {

    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
}

#Preview {
    BackgroundVideoPlayer()
}


