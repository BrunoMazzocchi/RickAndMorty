//
//  PlanetResidentList.swift
//  RickAndMorty
//
//  Created by Bruno Mazzocchi on 18/11/24.
//

import SwiftUI

struct PlanetResidentList: View {
    @StateObject private var viewModel: ResidentsViewModel
    
    init(residents: [String]) {
        _viewModel = StateObject(wrappedValue: ResidentsViewModel(residents: residents))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading Residents...")
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(viewModel.residentModels) { resident in
                        HStack {
                            AsyncImage(url: URL(string: resident.image)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                Text(resident.name)
                                    .font(.headline)
                                Text(resident.status)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Residents")
        }
    }
}

#Preview {
    PlanetResidentList(residents: [
        "https://rickandmortyapi.com/api/character/38",
        "https://rickandmortyapi.com/api/character/45"
    ])
}
