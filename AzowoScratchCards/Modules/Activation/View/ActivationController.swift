//
//  ActivationController.swift
//  AzowoScratchCards
//
//  Created by Marek Baláž on 22/07/2023.
//

import Foundation
import UIKit
import Combine

class ActivationController: UIViewController, ViewModelContainer {
    
    // MARK: - Outlets
    
    @IBOutlet weak var scratchCardView: ScratchCardView!
    
    // MARK: - Variables
    
    var viewModel: ActivationViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Actions
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
    
        scratchCardView.titleLbl.text = viewModel.scratchCardViewModel.titleText
        scratchCardView.playCodeLbl.text = viewModel.scratchCardViewModel.playCodeText
        viewModel.scratchCardViewModel.activateBtnAction = viewModel.activate
        
        viewModel.isLoading
            .receive(on: RunLoop.main)
            .sink { [weak self] isLoading in
                guard let self = self else { return }
                
                switch isLoading {
                case .isLoading:
                    self.scratchCardView.standardBtnView.startLoading()
                case .isFinished:
                    let generator = UIImpactFeedbackGenerator(style: .heavy)
                    generator.impactOccurred()
                    self.scratchCardView.standardBtnView.finishLoading(true)
                case .normal:
                    self.scratchCardView.standardBtnView.finishLoading()
                case .failed:
                    self.scratchCardView.standardBtnView.failed()
                }
    
            }
            .store(in: &cancellables)
        
        viewModel.scratchCardViewModel.$scratchCard
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                self.scratchCardView.numberLbl.text = String(self.viewModel.scratchCardViewModel.scratchCard.number)
            }
            .store(in: &cancellables)
        
        viewModel.scratchCardViewModel.$scratchCardState
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                
                self.scratchCardView.subtitleLbl.text = self.viewModel.scratchCardViewModel.getScratchCardStateText()
                if let playCode = self.viewModel.scratchCardViewModel.scratchCard.playCode {
                    self.scratchCardView.playCodeView.codeLbl.text = playCode
                }
                
                switch state {
                case .generated:
                    ()
                case .revealed:
                    self.scratchCardView.playCodeView.tapeProgressView.isHidden = true
                case .activated:
                    self.scratchCardView.playCodeView.tapeProgressView.isHidden = true
                    self.scratchCardView.bottomView.isHidden = true
                }
            }
            .store(in: &cancellables)
        
        viewModel.activationError
            .receive(on: RunLoop.main)
            .sink { errorMsg in
                SystemMessage.showToast(customString: errorMsg)
            }
            .store(in: &cancellables)
        
        viewModel.networkError
            .receive(on: RunLoop.main)
            .sink { desc in
                SystemMessage.showToast(customString: desc)
            }
            .store(in: &cancellables)
        
        if let config = self.viewModel.scratchCardViewModel.getScratchCardBtn() {
            self.scratchCardView.standardBtnView.configure(config)
        }
    }
    
    // MARK: - Implementation
    
}
