//
//  PlanetView.swift
//  RickAndMorty
//
//  Created by Bruno Mazzocchi on 18/11/24.
//

import SwiftUI

struct PlanetView: View {
    @StateObject private var viewModel = PlanetViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...") // Loader
                        .padding()
                } else {
                    List {
                        ForEach(viewModel.results, id: \.id) { planet in
                            NavigationLink (destination: PlanetResidentList(residents: planet.residents)){
                                VStack(alignment: .leading) {
                                    Text(planet.name)
                                        .font(.headline)
                                    Text("Type: \(planet.type)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        
                        if viewModel.hasNextPage {
                            Button(action: {
                                viewModel.loadNextPage()
                            }) {
                                HStack {
                                    Spacer()
                                    Text("Load More")
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Planet View List")
        }
        .onAppear {
            viewModel.loadCurrentPage()
        }
    }
}

#Preview {
    PlanetView()
}
