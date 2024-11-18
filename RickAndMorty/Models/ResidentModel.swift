//
//  ResidentModel.swift
//  RickAndMorty
//
//  Created by Bruno Mazzocchi on 18/11/24.
//

import Foundation

struct ResidentModel: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
}
