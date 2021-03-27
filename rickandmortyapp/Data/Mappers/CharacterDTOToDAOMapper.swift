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
                            type: character.type,
                            gender: character.gender,
                            origin: map(character.origin),
                            location: map(character.location),
                            image: character.image,
                            url: character.url)
    }
    
    fileprivate func map(_ origin: CharacterOriginDTO) -> CharacterOriginDAO {
        return CharacterOriginDAO(name: origin.name, url: origin.url)
    }
    
    fileprivate func map(_ origin: CharacterLocationDTO) -> CharacterLocationDAO {
        return CharacterLocationDAO(name: origin.name, url: origin.url)
    }
}
