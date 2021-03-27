//
//  CharacterListDTO.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 27/03/2021.
//

import Foundation

struct CharacterListDTO: Codable {
    var info: InfoDTO
    var characters: [CharacterDTO]

    enum CodingKeys: String, CodingKey {
        case info
        case characters = "results"
    }
}
