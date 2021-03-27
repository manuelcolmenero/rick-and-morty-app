//
//  CharacterDetailViewModel.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 27/03/2021.
//

import Foundation
import RxSwift

class CharacterDetailViewModel {
    // MARK: - Observables
    let needReloadData : PublishSubject<Bool> = PublishSubject()
    
    // MARK: - Properties
    
    // MARK: - Computed properties
    
    // MARK: - Private Properties
    
    // MARK: - Public functions
    func loadData() {
        self.needReloadData.onNext(true)
    }
    
    func sendButtonAction() {
        
    }
}
