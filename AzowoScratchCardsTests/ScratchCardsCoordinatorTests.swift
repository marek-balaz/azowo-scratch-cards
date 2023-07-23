//
//  ScratchCardsCoordinatorTests.swift
//  AzowoScratchCardsTests
//
//  Created by Marek Baláž on 22/07/2023.
//

import XCTest
@testable import AzowoScratchCards

class ScratchCardsCoordinatorTests: XCTestCase {
    
    var coordinator: ScratchCardsCoordinator!
    var navController: UINavigationController!
    
    override func setUp() {
        super.setUp()
        coordinator = ScratchCardsCoordinator()
        navController = coordinator.rootViewController
    }
    
    override func tearDown() {
        coordinator = nil
        navController = nil
        super.tearDown()
    }
    
    func testShowScratchCards() {
        coordinator.showScratchCards()
        
        let topVC = navController.topViewController
        XCTAssertTrue(topVC is ScratchCardsController)
    }
    
    func testShowRevelation() {
        let scratchCardViewModel = ScratchCardViewModel(scratchCard: ScratchCard(number: 1, generatedAt: Date()))
        coordinator.showRevelation(scratchCard: scratchCardViewModel)
        
        let topVC = navController.topViewController
        XCTAssertTrue(topVC is RevelationController)
        
        let revelationVC = topVC as! RevelationController
        XCTAssertNotNil(revelationVC.viewModel)
    }
    
    func testShowActivation() {
        let scratchCardViewModel = ScratchCardViewModel(scratchCard: ScratchCard(number: 1, generatedAt: Date()))
        coordinator.showActivation(scratchCard: scratchCardViewModel)
        
        let topVC = navController.topViewController
        XCTAssertTrue(topVC is ActivationController)
        
        let activationVC = topVC as! ActivationController
        XCTAssertNotNil(activationVC.viewModel)
    }
    
}
