//
//  PressableButtonStyle.swift
//  SiddhaMediaPlayer
//
//  Created by jalal on 11/18/24.
//

import SwiftUI

struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0) // Shrinks when pressed
            .opacity(configuration.isPressed ? 0.8 : 1.0)     // Fades slightly when pressed
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed) // Smooth animation
    }
}
