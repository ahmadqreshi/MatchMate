//
//  ProfileMatchesViewModel.swift
//  MatchMate
//
//  Created by Ahmad Qureshi on 27/01/25.
//

import Foundation
import Combine

final class ProfileMatchesViewModel: ObservableObject {
    @Published var userMatches: [ProfileMatchesModel] = []
    @Published var isLoading: Bool = false
    var errorMessage: String = ""
    
    
    private let dataRepo: ProfileMatchesDataRepository
    
    init(dataRepo: ProfileMatchesDataRepository) {
        self.dataRepo = dataRepo
    }
    
    func fetchUserMatches() {
        isLoading = true
        dataRepo.fetchProfileMatches { [weak self] data in
            DispatchQueue.main.async {
                self?.userMatches = data
                self?.isLoading = false
            }
            
        } failure: { [weak self] message in
            DispatchQueue.main.async {
                self?.isLoading = false
                self?.errorMessage = message
            }
        }
    }
    
}
