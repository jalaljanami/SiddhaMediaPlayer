//
//  PlayerProgressView.swift
//  SiddhaMediaPlayer
//
//  Created by jalal on 11/17/24.
//

import SwiftUI

struct PlayerProgressView: View {
    
    @StateObject var audioManager: AudioPlayerManager
    
//    @State var trackTimeSec: Double = 240
//    @State var trackCurrentTimeSec: Double = 0
    @State private var progress: Double = 0.0 // Progress range: 0 to 1
    @State private var barThickness: CGFloat = 10
    
        var body: some View {
            VStack {
                // Progress Bar

                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        // Background track
                        Capsule()
                            .fill(Color.white.opacity(0.2))
                            .frame(height: barThickness)
                            
                        // Progress track
                        Capsule()
                            .fill(Color.white)
                            .frame(width: CGFloat(progress) * UIScreen.main.bounds.width, height: barThickness)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .clipShape(.rect(cornerRadius: 20))
                    }
                    .frame(height: 20)
//                    .padding(.horizontal, 16)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newProgress = min(max(0, value.location.x / UIScreen.main.bounds.width), 1)
                                withAnimation {
                                    
                                    if newProgress > 1 {
                                        progress = 1
                                    } else {
                                        progress = newProgress
//                                        audioManager.seek(to: (Double(progress) * audioManager.duration))
                                    }
                                }
                                
                                withAnimation(.easeInOut(duration: 0.1)) {
                                    barThickness = 20
                                }
                            }
                            .onEnded { value in
                                
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    barThickness = 10
                                }
                            }.onEnded { _ in
                                audioManager.seek(to: (Double(progress) * audioManager.duration))
                            }
                    )
                    
                    
}
                // Time Labels
                HStack {
                    Text(timeString(for: audioManager.currentTime)) // Example: 240 seconds total
                        .font(.caption)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text(timeString(for: audioManager.duration)) // Total duration
                        .font(.caption)
                        .foregroundColor(.white)
                }
//                .padding(.horizontal, 16)
//                .frame(width: .infinity, height: 100)
                
            }
//            .onChange(of: audioManager.currentTime) { _,newProgress in
//                
//                    progress = newProgress / audioManager.duration
//                
//            }
        }
        
        // Helper: Format time
        private func timeString(for seconds: Double) -> String {
            let minutes = Int(seconds) / 60
            let seconds = Int(seconds) % 60
            return String(format: "%d:%02d", minutes, seconds)
        }
}

//#Preview {
//    PlayerProgressView()
//}
