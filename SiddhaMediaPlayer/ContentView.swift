//
//  ContentView.swift
//  SiddhaMediaPlayer
//
//  Created by jalal on 11/16/24.
//

import SwiftUI
import AVKit

struct ContentView: View {
    
    @State private var isPlaying: Bool = false
    
    var body: some View {
        
        ZStack {
            
            BackgroundVideoPlayer(isPlaying: $isPlaying)
                .allowsHitTesting(false)
            
            AudioPlayerView(isPlaying: $isPlaying)
//            Color.black.edgesIgnoringSafeArea(.all)
//            VStack {
//                Spacer()
            
//            }
//            VStack {
//                Spacer()
//                VStack(alignment: .leading) {
//                    Text("Title")
//                        .font(.title).bold()
//                        .foregroundStyle(.white)
//                    
//                    Text("Description")
//                        .font(.subheadline)
//                        .foregroundStyle(.white)
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.horizontal, 24)
//                
////                ProgressView(value: 100, total: 100) {
////                       
////                } currentValueLabel: {
////                            
////                }
////                    .progressViewStyle(.linear)
////                    .frame(height: 20)
////                    .frame(maxWidth: .infinity)
//                
////                PlayerProgressView(trackTimeSec: 1000)
//                    .frame(height: 40)
//                    .padding(.horizontal, 24)
//                HStack {
//                    Spacer(minLength: 32)
//                    
//                    Button {
//                        //
//                    } label: {
//                        Image(uiImage: .add)
//                            .resizable()
//                            .aspectRatio(1, contentMode: .fit)
//                            .frame(maxWidth: .infinity, maxHeight: 50)
//                    }
//                    
//                    Button {
//                        //
//                    } label: {
//                        
//                        Image(uiImage: .add)
//                            .resizable()
//                            .foregroundStyle(.white)
//                            .colorInvert()
//                            .aspectRatio(1, contentMode: .fit)
//                            .frame(maxWidth: .infinity, maxHeight: 75)
//                    }
//                    
//                    Button {
//                        //
//                    } label: {
//                        Image(systemName: "15.arrow.trianglehead.clockwise")
//                            
//                            .foregroundStyle(.white)
//                            .aspectRatio(1, contentMode: .fit)
//                            .frame(maxWidth: .infinity, maxHeight: 50)
//                    }
//                    Spacer(minLength: 32)
//                }
//                .frame(maxWidth: .infinity)
//                .padding(32)
////                .padding(32)
//            }
        }
    }
}

#Preview {
    ContentView()
}
