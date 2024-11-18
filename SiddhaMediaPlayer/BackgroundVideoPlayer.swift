//
//  BackgroundVideoPlayer.swift
//  SiddhaMediaPlayer
//
//  Created by jalal on 11/16/24.
//

import SwiftUI
import AVKit

struct BackgroundVideoPlayer: View {
    
    @Binding var isPlaying: Bool

    let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Class category mobile", ofType: "mp4")!))
        var body: some View {
            LoopingVideoView(player: player)
                .ignoresSafeArea()
                .onAppear {
                    if isPlaying {
                        player.play()
                    }
                }
                .onChange(of: isPlaying) { oldValue, newValue in
                    if newValue {
                        player.play()
                        isPlaying = true
                    } else {
                        player.pause()
                        isPlaying = false
                    }
                }
//                .onTapGesture {
//                    if isPlaying {
//                        player.pause()
//                        isPlaying.toggle()
//                    } else {
//                        player.play()
//                        isPlaying.toggle()
//                    }
//                }
        }
}

struct LoopingVideoView : UIViewControllerRepresentable {

    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        
        // Add observer to loop the video
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main
        ) { _ in
            player.seek(to: .zero)
            player.play()
        }
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
}

#Preview {
    BackgroundVideoPlayer(isPlaying: .constant(true))
}


