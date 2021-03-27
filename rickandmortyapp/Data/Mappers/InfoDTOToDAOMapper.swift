//
//  InfoDTOToDAOMapper.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 27/03/2021.
//

import Foundation

/// Mapper InfoDTO to InfoDAO
class InfoDTOToDAOMapper {
    func map(_ info: InfoDTO) -> InfoDAO {
        return InfoDAO(totalCharacters: info.totalCharacters,
                       totalPages: info.totalPages,
                       nextUrl: info.nextUrl,
                       prevUrl: info.prevUrl)
    }
}
