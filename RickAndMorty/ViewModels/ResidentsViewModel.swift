//
//  ResidentsViewModel.swift
//  RickAndMorty
//
//  Created by Bruno Mazzocchi on 18/11/24.
//

import Foundation
import Combine

final class ResidentsViewModel: ObservableObject {
    // Input: List of resident URLs
    private let residents: [String]
    
    // Output: Published list of resident models
    @Published var residentModels: [ResidentModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    init(residents: [String]) {
        self.residents = residents
        preloadResidents()
    }
    
    /// Fetches the data for all residents.
    private func preloadResidents() {
        isLoading = true
        errorMessage = nil
        
        let publishers = residents.compactMap { URL(string: $0) }
            .map { url in
                URLSession.shared.dataTaskPublisher(for: url)
                    .map(\.data)
                    .decode(type: ResidentModel.self, decoder: JSONDecoder())
                    .catch { error -> Empty<ResidentModel, Never> in
                        print("Error fetching resident data: \(error)")
                        return Empty()
                    }
                    .eraseToAnyPublisher()
            }
        
        Publishers.MergeMany(publishers)
            .collect()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] residents in
                self?.residentModels = residents
            })
            .store(in: &cancellables)
    }
}
