//
//  ViewModelContainer.swift
//  AzowoScratchCards
//
//  Created by Marek Baláž on 22/07/2023.
//

import Foundation

protocol ViewModelContainer {
    associatedtype ViewModel: ViewModelType
    
    var viewModel: ViewModel! { get }
    
    func bind()
}
