//
//  Typealias.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 27/03/2021.
//

import Foundation

// MARK: - Blocks for callbacks

// Define new type closure for return data
typealias ServiceCompletion = (_ result: ServiceResult) -> ()

// Define new type closure for actions
typealias VoidBlock = () -> Void
