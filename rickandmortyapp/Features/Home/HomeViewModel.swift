//
//  HomeViewModel.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 27/03/2021.
//

import Foundation
import RxSwift

class HomeViewModel {
    // MARK: - Observables
    let needReloadData : PublishSubject<Bool> = PublishSubject()
    let needNavigateTo : PublishSubject<(Scene, Any?)> = PublishSubject()
    let needReloadCell : PublishSubject<Int> = PublishSubject()    
    let needShowAlert : PublishSubject<String> = PublishSubject()
    
    // MARK: - Properties
    var infoList: InfoDAO?
    var characters: [CharacterDAO] = []
    
    // MARK: - Computed properties
    var areMoreCharacters: Bool {
        return infoList?.nextUrl != nil
    }
    
    var numberOfPage: Int {
        if areMoreCharacters {
            guard let page = infoList?.nextUrl?.trimPage() else { return 0 }
            return Int(page) ?? 0
        }
        return 0
    }
    
    // MARK: - Private Properties
    
    // MARK: - Public functions
    func loadData() {
        fetchCharacterList()
    }
    
    func character(by index: Int) -> CharacterDAO? { characters[index] }
    func index(by id: Int) -> Int? { characters.firstIndex { $0.id == id } ?? nil }
    
    func onUpdateData(withReset reset: Bool) {
        if reset {
            characters = []
        }
        
        fetchCharacterList()
    }
    
    func onCharacterPressed(_ index: Int) {
        showLocationDetail(for: index)
    }
    
    func updateFavorite(for id: Int) -> Bool{
        let dataManager = DataManager.shared
        
        return dataManager.getFavorite(id)
    }
    
    func favoriteAction(for id: Int, and index: Int) {
        let dataManager = DataManager.shared
        let character = characters[index]
        
        if character.favorite {
            dataManager.removeFavorite(character.id)
        } else {
            dataManager.addFavorite(character.id)
        }
        
        characters[index].favorite = !(character.favorite)
        
        self.needReloadCell.onNext(index)
    }
    
    // MARK: - Data functions
    /// Get all layouts for home
    fileprivate func fetchCharacterList() {
        
        let dataManager = DataManager.shared
        dataManager.fetchCharacters(inPage: numberOfPage) { (result) in
            switch result {
            case .success(data: let data):
                self.parseData(data)
                self.needReloadData.onNext(true)
                
            case .failure(error: let error):
                self.needShowAlert.onNext(error ?? NSLocalizedString("error_standar", comment: ""))
            }
        }
    }
    
    fileprivate func parseData(_ data: Any?) {
        guard let charlist = data as? CharacterListDAO else { return }
        
        self.infoList = charlist.info
        self.characters.append(contentsOf: charlist.characters)
    }
    
    private func showLocationDetail(for index: Int) {
        guard let character = character(by: index) else { return }
        
        needNavigateTo.onNext((.characterDetail, character))
    }
}
