//
//  GameModel.swift
//  MatchTwo
//
//  Created by Yerzhan Parimbay on 29.08.2025.
//

import Foundation

struct GameModel {
    var images = ["AR", "BR", "CH", "FR", "GR", "KR", "KZ", "US", "AR", "BR", "CH", "FR", "GR", "KR", "KZ", "US"]
    var shuffledImages: [String] = []
    var winState: [[Int]] = []
    
    mutating func newGame() {
        shuffledImages = images.shuffled()
        
        for (i, image) in shuffledImages.enumerated() {
            for (j, otherImage) in shuffledImages.enumerated() {
                if i < j && image == otherImage {
                    winState.append([i, j])
                }
            }
        }
        images = shuffledImages
    }
}
