//
//  ActivateViewModel.swift
//  AzowoScratchCards
//
//  Created by Marek Baláž on 22/07/2023.
//

import Foundation
import Combine

class ActivationViewModel: ViewModelType {
    
    @Published var scratchCardViewModel: ScratchCardViewModel
    
    var activationService: ActivationServiceProtocol
    var isLoading = PassthroughSubject<StandarbButtonState, Never>()
    var networkError = PassthroughSubject<String, Never>()
    var activationError = PassthroughSubject<String, Never>()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(scratchCardViewModel: ScratchCardViewModel, activationService: ActivationServiceProtocol) {
        self.scratchCardViewModel = scratchCardViewModel
        self.activationService = activationService
    }
    
    func bind() {
    }
    
    func activate() {
        
        guard let playCode = scratchCardViewModel.scratchCard.playCode else {
            Log.d("Missing play code.")
            return
        }

        isLoading.send(.isLoading)
        activationService.getActivation(playCode: playCode)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                
                switch completion {
                case .failure(let error):
                    self.isLoading.send(.normal)
                    self.networkError.send(error.localizedDescription)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] activationResponse, statusCode in
                guard let self = self else { return }
                
                switch statusCode {
                case 200..<300:
                    if activationResponse.status == "ok" {
                        self.isLoading.send(.isFinished)
                        self.scratchCardViewModel.scratchCard.activatedAt = Date.serverDate(dateString: activationResponse.now)
                        self.scratchCardViewModel.scratchCardState = .activated
                        self.scratchCardViewModel.scratchCardUpdated.send(self.scratchCardViewModel.scratchCard)
                    } else {
                        self.isLoading.send(.failed)
                        self.activationError.send(("Activation failed. Try again later."))
                    }
                case 300..<600:
                    self.isLoading.send(.normal)
                    self.networkError.send(String(statusCode))
                default:
                    self.isLoading.send(.normal)
                    self.networkError.send("Unknown error occured.")
                }

            })
            .store(in: &cancellables)
        
    }
    
}

