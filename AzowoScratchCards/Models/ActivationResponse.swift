//
//  VersionModel.swift
//  AzowoScratchCards
//
//  Created by Marek Baláž on 22/07/2023.
//

import Foundation

struct ActivationResponse: Codable {
    
    let now: String
    let status: String
    let failures: [String]
    
}
