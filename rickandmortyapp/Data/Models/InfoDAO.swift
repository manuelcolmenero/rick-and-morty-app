//
//  InfoDAO.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 27/03/2021.
//

import Foundation

struct InfoDAO: Codable {
    var totalCharacters: Int
    var totalPages: Int
    var nextUrl: String?
    var prevUrl: String?

    enum CodingKeys: String, CodingKey {
        case totalCharacters = "count"
        case totalPages = "pages"
        case nextUrl = "next"
        case prevUrl = "prev"
    }
}
