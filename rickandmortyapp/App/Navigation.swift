//
//  Navigation.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 27/03/2021.
//

import UIKit

enum Scene {
    case characterDetail
    case locationDetail
}

enum Segue: String {
    case homeToCharacterDetail = "segueHomeToCharacterDetail"
    case characterDetailToLocationDetail = "segueCharacterDetailToLocationDetail"
}

extension UIViewController {
    func navigateTo(_ segue: Segue, sender: Any? = nil) {
        DispatchQueue.main.async() { [weak self] in
            self?.performSegue(withIdentifier: segue.rawValue,
                               sender: sender)
        }
    }
}
