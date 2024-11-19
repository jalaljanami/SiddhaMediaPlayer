//
//  SkipButton.swift
//  SiddhaMediaPlayer
//
//  Created by jalal on 11/19/24.
//

import SwiftUI

// MARK: - Reusable Components

/// A button that allows the user to skip to the next track or action.
struct SkipButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Text("Skip")
                    .foregroundStyle(.white)
                    .bold()
                
                Image(systemName: "forward.end.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
                    .background(.clear)
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(width: 88, height: 40)
        .background(.white.opacity(0.3))
        .clipShape(Capsule())
    }
}
