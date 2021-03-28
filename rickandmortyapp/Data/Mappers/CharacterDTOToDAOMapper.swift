//
//  CharacterDTOToDAOMapper.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 27/03/2021.
//

import Foundation

/// Mapper CharacterDTO to CharacterDAO
class CharacterDTOToDAOMapper {
    func map(_ characters: [CharacterDTO]) -> [CharacterDAO] {
        var charactersDAO : [CharacterDAO] = []
        
        characters.forEach { (character) in
            charactersDAO.append(map(character))
        }
        
        return charactersDAO
    }
    
    fileprivate func map(_ character: CharacterDTO) -> CharacterDAO {
        return CharacterDAO(id: character.id,
                            name: character.name,
                            status: character.status,
                            species: character.species,
                            gender: character.gender,
                            origin: map(character.origin),
                            location: map(character.location),
                            image: character.image,
                            favorite: false)
    }
    
    fileprivate func map(_ location: CharacterLocationDTO) -> CharacterLocationDAO {
        return CharacterLocationDAO(name: location.name, url: location.url)
    }
}
