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
    
    // MARK: - Remote
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
                    callback(ServiceResult.failure(error: NSLocalizedString("error_call_data", comment: "")))
                    return
                }
                
                // Mapper DTO to DAO
                let listDAO = CharacterListDTOToDAOMapper().map(listDTO)
                                
                // Return success result with characters
                callback(ServiceResult.success(data: listDAO))
                
            case .failure(error: let error):
                // return failure string
                callback(ServiceResult.failure(error: error))
            }
        }
    }
    
    
    /// Call to get a single location 
    /// - Parameters:
    ///   - urlLocation: URL of the location to obtain
    ///   - callback: closure for return data
    func fetchLocation(url urlLocation: String, callback: @escaping ServiceCompletion) {
        
        let apiManager = ApiManager.shared
        apiManager.fetchLocation(urlLocation) { (result) in
            
            switch result {
            case .success(data: let location):
                
                // Data validation
                guard let locationDTO = location as? LocationDTO else {
                    callback(ServiceResult.failure(error: NSLocalizedString("error_call_data", comment: "")))
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
    
    // MARK: - Local
    /// Obtaining if a character has been marked as a favorite
    /// - Parameter Character ID
    /// - Returns:Boolean value indicating whether the item is favorite or not
    func getFavorite(_ id: Int) -> Bool {
        let userDefaults = UserDefaultsManager.shared
        let favorites = userDefaults.getFavoriteCharacters()
        
        return (favorites.first { $0 == id } != nil)
    }
    
    
    /// Marking a character as a favorite
    /// - Parameter id: Character ID
    func addFavorite(_ id: Int) {
        let userDefaults = UserDefaultsManager.shared
        var favorites = userDefaults.getFavoriteCharacters()
        
        favorites.append(id)
        
        userDefaults.saveFavoriteCharacters(favorites)
    }
    
    /// Unmarked a character as favorite
    /// - Parameter id: Character ID
    func removeFavorite(_ id: Int) {
        
        let userDefaults = UserDefaultsManager.shared
        let favorites = userDefaults.getFavoriteCharacters()
        
        let newFavorites = favorites.filter { $0 != id }
        
        userDefaults.saveFavoriteCharacters(newFavorites)        
    }
}
