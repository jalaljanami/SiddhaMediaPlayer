//
//  Meditation.swift
//  SiddhaMediaPlayer
//
//  Created by jalal on 11/19/24.
//

import Foundation

struct Meditation {
    var name: String
    var filename: String
    var arthur: String
    var isLiked: Bool
    
    mutating func toggleLike() {
        isLiked.toggle()
    }
}
