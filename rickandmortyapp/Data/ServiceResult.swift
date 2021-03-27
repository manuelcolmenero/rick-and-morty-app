//
//  Typealias.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 27/03/2021.
//

import Foundation

// Service result enum with data parameters
enum ServiceResult {
    case success(data: Any?)
    case failure(error: String?)
}

// Define new type closure for return data
typealias ServiceCompletion = (_ result: ServiceResult) -> ()
