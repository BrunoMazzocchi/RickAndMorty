//
//  EearthModel.swift
//  RickAndMorty
//
//  Created by Bruno Mazzocchi on 18/11/24.
//

import Foundation

struct EarthModel: Codable, Identifiable {
    var id: Int
    var name: String
    var type: String
    var dimension: String
    var residents: [String]
    var url: String
    var created: String
    
    
    var totalResidents : Int {
        residents.count
    }
}
