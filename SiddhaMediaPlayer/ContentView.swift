//
//  ContentView.swift
//  SiddhaMediaPlayer
//
//  Created by jalal on 11/16/24.
//

import SwiftUI
import AVKit

struct ContentView: View {
    
    var body: some View {
        
        ZStack {
            BackgroundVideoPlayer()
            
            VStack(alignment: .leading) {
                Text("Title")
                    .font(.title)
                Text("Description")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    ContentView()
}
