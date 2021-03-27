//
//  CharacterListDAO.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 27/03/2021.
//

import Foundation

struct CharacterListDAO: Codable {
    var info: InfoDAO
    var characters: [CharacterDAO]

    enum CodingKeys: String, CodingKey {
        case info
        case characters = "results"
    }
}
