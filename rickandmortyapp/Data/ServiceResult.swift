//
//  ServiceResult.swift
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
