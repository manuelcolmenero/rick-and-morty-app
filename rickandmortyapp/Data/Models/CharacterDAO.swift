//
//  CharacterDAO.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 27/03/2021.
//

import Foundation

struct CharacterDAO: Codable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var gender: String
    var origin: CharacterLocationDAO
    var location: CharacterLocationDAO
    var image: String
    var favorite: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case species
        case gender
        case origin
        case location
        case image
        case favorite
    }
}

struct CharacterLocationDAO: Codable {
    var name: String
    var url: String

    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}
