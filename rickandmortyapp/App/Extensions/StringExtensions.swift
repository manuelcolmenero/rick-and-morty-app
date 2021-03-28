//
//  StringExtensions.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 28/03/2021.
//

import Foundation

extension String {
    func trimPage() -> String {
        self.trimmingCharacters(in: CharacterSet(charactersIn: ApiRouter.characterPagePath.rawValue))
    }
}
