//
//  PlanetViewModel.swift
//  RickAndMorty
//
//  Created by Bruno Mazzocchi on 18/11/24.
//

import Foundation
import Combine

final class PlanetViewModel: ObservableObject {
    private var currentPage = 1
    private var cancellables = Set<AnyCancellable>()
    private var totalPages = 1
    
    @Published var isLoading = false
    @Published var results: [EarthModel] = []
    @Published var result: Result<PaginatedModel<EarthModel>, Error> = .failure(
        NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data available"])
    )
    
    var hasNextPage: Bool {
        currentPage < totalPages
    }
    
    private var urlBase: String {
        "https://rickandmortyapi.com/api/location?page=\(currentPage)"
    }
    
    func loadCurrentPage() {
        guard !isLoading else { return }
        isLoading = true
        
        guard let url = URL(string: urlBase) else {
            self.result = .failure(URLError(.badURL))
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: PaginatedModel<EarthModel>.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.result = .failure(error)
                case .finished:
                    break
                }
            } receiveValue: { paginatedModel in
                self.results.append(contentsOf: paginatedModel.results)
                self.totalPages = paginatedModel.info.pages
                self.currentPage += 1
                self.result = .success(paginatedModel)
            }
            .store(in: &cancellables)
    }
    
    func loadNextPage() {
        guard hasNextPage else { return }
        loadCurrentPage()
    }
}

