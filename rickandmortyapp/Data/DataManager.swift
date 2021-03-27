//
//  DataManager.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 27/03/2021.
//

import Foundation

/// Class for managing local and remote data
class DataManager {
    // MARK: - SINGLETON implementation
    // Object unique instance
    static let shared = DataManager()
    
    // Initializer access level change now
    private init() {}
    
    /// Call to get the list of characters
    /// - Parameters:
    ///   - page: Page number to request
    ///   - callback: closure for return data
    func fetchCharacters(inPage page: Int = 0, callback: @escaping ServiceCompletion) {
        
        let apiManager = ApiManager.shared
        apiManager.fetchCharacters(inPage: page) { (result) in
        
            switch result {
            case .success(data: let characterList):
                
                // Data validation
                guard let listDTO = characterList as? CharacterListDTO else {
                    callback(ServiceResult.failure(error: "Call without data. Contact us")) // TODO: Change harcode
                    return
                }
                
                // Mapper DTO to DAO
                let listDAO = CharacterListDTOToDAOMapper().map(listDTO)
                
                // TODO: Find in userDefault if ID is Favorite
                
                // Return success result with characters
                callback(ServiceResult.success(data: listDAO))
                
            case .failure(error: let error):
                // return failure string
                callback(ServiceResult.failure(error: error))
            }
        }
    }
    
    func fetchLocation(url urlLocation: String, callback: @escaping ServiceCompletion) {
        
        let apiManager = ApiManager.shared
        apiManager.fetchLocation(urlLocation) { (result) in
        
            switch result {
            case .success(data: let location):
                
                // Data validation
                guard let locationDTO = location as? LocationDTO else {
                    callback(ServiceResult.failure(error: "Call without data. Contact us")) // TODO: Change harcode
                    return
                }
                
                // Mapper DTO to DAO
                let locationDAO = LocationDTOToDAOMapper().map(locationDTO)
                
                // Return success result with characters
                callback(ServiceResult.success(data: locationDAO))
                
            case .failure(error: let error):
                // return failure string
                callback(ServiceResult.failure(error: error))
            }
        }
    }
}
