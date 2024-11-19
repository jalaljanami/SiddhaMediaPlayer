//
//  Constants.swift
//  SiddhaMediaPlayer
//
//  Created by jalal on 11/19/24.
//

import SwiftUI

/// A struct that holds all constant values used throughout the app.
/// These constants are organized into namespaces for better clarity and maintainability.
struct Constants {
    
    /// A namespace for UI-related constants.
    struct UI {
        
        /// The main padding value used across the app's views.
        static let mainPadding: CGFloat = 16
        
        /// The screen width of the device.
        static var screenWidth: CGFloat {
            UIScreen.main.bounds.width
        }
        
        /// The screen width with the main padding applied on both sides.
        static var paddedScreenWidth: CGFloat {
            screenWidth - (2 * mainPadding)
        }
        
        /// A small size relative to the screen width, calculated as 8% of the padded width.
        static var smallRelativeToScreenWidth: CGFloat {
            paddedScreenWidth * 0.08
        }
        
        /// Small padding, typically used for minor spacing adjustments.
        static let smallPadding: CGFloat = 8
        
        /// Medium padding, suitable for moderate spacing between UI elements.
        static let mediumPadding: CGFloat = 16
        
        /// Large padding, used for significant spacing or margin between components.
        static let largePadding: CGFloat = 24
    }
    
    struct Model {
        static let meditation = Meditation(
            name: "Improving Creativity",
            filename: "Improving Creativity-Mychal-15m-895s-v2",
            arthur: "Mychal Prieto",
            isLiked: false
        )
    }
}
