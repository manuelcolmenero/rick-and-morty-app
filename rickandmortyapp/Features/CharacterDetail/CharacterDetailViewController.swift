//
//  CharacterDetailViewController.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 27/03/2021.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    var character: CharacterDAO?
    
    // MARK: - Properties
    
    // MARK: - IBOutlet
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = character?.name
    }
}
