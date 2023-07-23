//
//  AppCoordinator.swift
//  AzowoScratchCards
//
//  Created by Marek Baláž on 22/07/2023.
//

import Foundation
import UIKit
 
class AppCoordinator: Coordinator {
    
    private var window = UIWindow(frame: UIScreen.main.bounds)
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        showScratchCards()
    }
    
    func showScratchCards() {
        let scratchCardCoordinator = ScratchCardsCoordinator()
        scratchCardCoordinator.start()
        self.window.rootViewController = scratchCardCoordinator.rootViewController
    }
    
}
