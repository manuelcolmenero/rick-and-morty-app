//
//  ApiManager.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 27/03/2021.
//

import Foundation
import Alamofire
import AlamofireImage

class ApiManager {
    // MARK: - SINGLETON implementation
    // Object unique instance
    static let shared = ApiManager()
    
    // Initializer access level change now
    private init() {}
    
    // MARK: - Properties
    private let characterPath = "https://rickandmortyapi.com/api/character"
    private let locationPath = "https://rickandmortyapi.com/api/location/"
    
    
    // MARK: - Core
    
    // MARK: - Data
    /// Endpoint to fetch a paginated list of characters providing the page number to request (20 per page).
    func fetchCharacters(inPage page: Int = 0, callback: @escaping ServiceCompletion) {
        var params: [String: Any] = [:]
        
        if (page > 0) {
            params["page"] = page
        }
        
        let request = AF.request(characterPath, method: .get, parameters: params)
        request.responseDecodable { (response: AFDataResponse<CharacterListDTO>) in
            
            // Response data decoded
            // response.value is a type of CharacterListDTO
            if let characterList = response.value {
                // Notify to callback data success result
                // and send parsed data
                callback(ServiceResult.success(data: characterList))
            } else {
                // Notify to callback data error message
                // and send custom text
                callback(ServiceResult.failure(error: "Service error parse response data"))
            }
        }
    }
    
    /// GET https://rickandmortyapi.com/api/location/{location_id}
    /// Endpoint to fetch the details of a location.
    func fetchLocation(_ urlPath: String, callback: @escaping ServiceCompletion) {
        
        let params: [String: Any] = [:]
        
        let request = AF.request(urlPath, method: .get, parameters: params)
        request.responseDecodable { (response: AFDataResponse<LocationDTO>) in
            
            // Response data decoded
            // response.value is a type of LocationDTO
            if let location = response.value {
                // Notify to callback data success result
                // and send parsed data
                callback(ServiceResult.success(data: location))
            } else {
                // Notify to callback data error message
                // and send custom text
                callback(ServiceResult.failure(error: "Service error parse response data"))
            }
        }
    }
}
