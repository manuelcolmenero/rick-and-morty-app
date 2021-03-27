//
//  LocationDTOToDAOMapper.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 27/03/2021.
//

import Foundation

/// Mapper InfoDTO to InfoDAO
class LocationDTOToDAOMapper {
    func map(_ location: LocationDTO) -> LocationDAO {
        return LocationDAO(id: location.id,
                           name: location.name,
                           type: location.type,
                           dimension: location.dimension,
                           residents: location.residents)
    }
}
