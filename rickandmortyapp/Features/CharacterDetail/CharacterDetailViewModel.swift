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
    let needNavigateTo : PublishSubject<(Scene, Any?)> = PublishSubject()
    let needChangeFavorite : PublishSubject<Bool> = PublishSubject()
    
    // MARK: - Properties
    var character: CharacterDAO?
    
    // MARK: - Computed properties
    
    // MARK: - Private Properties
    
    // MARK: - Public functions
    func loadData() {
        updateFavorite()
        self.needReloadData.onNext(true)
    }
    
    func locationAction(_ type: LocationTypes) {
        needNavigateTo.onNext((.locationDetail, type))
    }
    
    func favoriteAction() {
        guard let char = character else { return }
        
        let dataManager = DataManager.shared
            
        if char.favorite {
            dataManager.removeFavorite(char.id)
        } else {
            dataManager.addFavorite(char.id)
        }
        
        character?.favorite = !(char.favorite)
            
        self.needReloadData.onNext(true)
        self.needChangeFavorite.onNext(true)
    }
    
    // MARK: - Private functions
    func updateFavorite() {
        guard let char = character else { return }
        
        let dataManager = DataManager.shared
        
        character?.favorite = dataManager.getFavorite(char.id)
    }
}
