//
//  CharacterDTO.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 27/03/2021.
//

import Foundation

struct CharacterDTO: Codable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: CharacterLocationDTO
    var location: CharacterLocationDTO
    var image: String
    var episode: [String]
    var url: String
    var created: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case species
        case type
        case gender
        case origin
        case location
        case image
        case episode
        case url
        case created
    }
}

struct CharacterLocationDTO: Codable {
    var name: String
    var url: String

    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}
