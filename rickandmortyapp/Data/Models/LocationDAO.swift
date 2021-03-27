//
//  LocationDAO.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 27/03/2021.
//

import Foundation

struct LocationDAO: Codable {
    var id: Int
    var name: String
    var type: String
    var dimension: String
    var residents: [String]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case dimension
        case residents
    }
}
