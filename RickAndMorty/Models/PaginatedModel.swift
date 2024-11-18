//
//  PaginatedModel.swift
//  RickAndMorty
//
//  Created by Bruno Mazzocchi on 18/11/24.
//

struct PaginatedModel<Value: Codable>: Codable {
    var info: InfoModel
    /// Can be a character, planet information, etc.
    let results: [Value]
}

struct InfoModel: Codable {
    var count: Int
    var pages: Int
    let next: String?
    let previous: String?
}
