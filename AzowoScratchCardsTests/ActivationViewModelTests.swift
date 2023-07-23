//
//  ActivationViewModelTests.swift
//  AzowoScratchCardsTests
//
//  Created by Marek Baláž on 22/07/2023.
//

import Combine
import XCTest
@testable import AzowoScratchCards

class ActivationViewModelTests: XCTestCase {
    
    var activationServiceMock: ActivationServiceMock!
    var viewModel: ActivationViewModel!
    var cancellables: Set<AnyCancellable> = []
    
    func testActivateValidStatus() {
        
        let scratchCardViewModel = ScratchCardViewModel(scratchCard: ScratchCard(number: 1, generatedAt: Date(), revealedAt: Date()))
        activationServiceMock = ActivationServiceMock(activationResponse: ActivationResponse(now: "2023-07-23T07:41:24+00:00", status: "ok", failures: []), statusCode: 200)
        viewModel = ActivationViewModel(scratchCardViewModel: scratchCardViewModel, activationService: activationServiceMock)
        
        viewModel.scratchCardViewModel.scratchCard.playCode = UUID().uuidString
        
        viewModel = ActivationViewModel(
            scratchCardViewModel: viewModel.scratchCardViewModel,
            activationService: activationServiceMock
        )
        
        let expectation = XCTestExpectation(description: "Activation succeeded")
        viewModel.scratchCardViewModel.scratchCardUpdated
            .sink { updatedScratchCard in
                if updatedScratchCard.activatedAt != nil {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.activate()

        wait(for: [expectation], timeout: 1.0)
        XCTAssertNotNil(viewModel.scratchCardViewModel.scratchCard.activatedAt)
        XCTAssertEqual(viewModel.scratchCardViewModel.scratchCardState, .activated)
    }
    
    func testActivateInvalidStatus() {
        
        let scratchCardViewModel = ScratchCardViewModel(scratchCard: ScratchCard(number: 1, generatedAt: Date(), revealedAt: Date()))
        scratchCardViewModel.scratchCardState = .revealed
        activationServiceMock = ActivationServiceMock(activationResponse: ActivationResponse(now: "2023-07-23T07:41:24+00:00", status: "not_ok", failures: []), statusCode: 200)
        viewModel = ActivationViewModel(scratchCardViewModel: scratchCardViewModel, activationService: activationServiceMock)
        
        viewModel.scratchCardViewModel.scratchCard.playCode = UUID().uuidString
        
        viewModel = ActivationViewModel(
            scratchCardViewModel: viewModel.scratchCardViewModel,
            activationService: activationServiceMock
        )
        
        let expectation = XCTestExpectation(description: "Activation failed")
        viewModel.activationError
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.activate()

        wait(for: [expectation], timeout: 1.0)
        XCTAssertNil(viewModel.scratchCardViewModel.scratchCard.activatedAt)
        XCTAssertEqual(viewModel.scratchCardViewModel.scratchCardState, .revealed)
    }
    
}
