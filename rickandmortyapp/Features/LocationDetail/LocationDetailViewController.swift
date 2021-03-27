//
//  LocationDetailViewController.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 27/03/2021.
//

import Foundation
import RxSwift

class LocationDetailViewController: UIViewController {
    
    // MARK: - Public properties
    var location: CharacterLocationDAO?
    
    // MARK: - Properties
    
    // MARK: - IBOutlet
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = location?.name
    }
    
    // MARK: - Configure methods
    private func configureView() {
        
    }
    
    // MARK: - Observers functions
    private func configureObservers() {
        
    }
}
