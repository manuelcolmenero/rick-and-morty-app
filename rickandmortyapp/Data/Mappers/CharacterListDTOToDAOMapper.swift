//
//  CharacterListDTOToDAOMapper.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 27/03/2021.
//

import Foundation

/// Mapper CharacterListDTO to CharacterListDAO
class CharacterListDTOToDAOMapper {
    func map(_ characterList: CharacterListDTO) -> CharacterListDAO {
        let infoDAO = InfoDTOToDAOMapper().map((characterList.info))
        let charactersDAO = CharacterDTOToDAOMapper().map(characterList.characters)
        
        return CharacterListDAO(info: infoDAO, characters: charactersDAO)
    }
}
