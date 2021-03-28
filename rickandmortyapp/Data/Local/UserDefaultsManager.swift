//
//  UserDefaultsManager.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 28/03/2021.
//

import Foundation

class UserDefaultsManager {
    // MARK: - Global variables
    private static let FAVORITES =  "favorites"
    
    // MARK: - SINGLETON implementation
    // Object unique instance
    static let shared = UserDefaultsManager()
    
    // Initializer access level change now
    private init() {}
    
    
    func getFavoriteCharacters() -> [Int] {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: UserDefaultsManager.FAVORITES) as? [Int] ?? []
    }
    
    func saveFavoriteCharacters(_ data: [Int]) {
        let defaults = UserDefaults.standard
        defaults.set(data, forKey: UserDefaultsManager.FAVORITES)
        defaults.synchronize()
    }
}
