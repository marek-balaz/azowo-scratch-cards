//
//  ScratchCard.swift
//  AzowoScratchCards
//
//  Created by Marek Baláž on 22/07/2023.
//

import Foundation

struct ScratchCard: Codable {

    let number: Int
    var playCode: String?
    let generatedAt: Date
    var revealedAt: Date?
    var activatedAt: Date?
    
}
