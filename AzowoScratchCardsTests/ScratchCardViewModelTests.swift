//
//  ScratchCardsViewModelTests.swift
//  AzowoScratchCardsTests
//
//  Created by Marek Baláž on 22/07/2023.
//

import XCTest
@testable import AzowoScratchCards

class ScratchCardsViewModelTests: XCTestCase {

    var viewModel: ScratchCardsViewModel!
    var generatorService: ScratchCardGeneratorService!
    
    override func setUp() {
        super.setUp()
        generatorService = ScratchCardGeneratorService()
        viewModel = ScratchCardsViewModel(scratchCardGeneratorService: generatorService)
    }

    override func tearDown() {
        generatorService = nil
        viewModel = nil
        super.tearDown()
    }

    func testFetchDataOnViewModelInit() {
        XCTAssertEqual(viewModel.scratchCards.count, 1)
        XCTAssertNil(viewModel.scratchCards.first?.playCode)
    }

}
