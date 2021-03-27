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
    
    // MARK: - Properties
    var infoList: InfoDAO?
    var characters: [CharacterDAO] = []
    
    // MARK: - Computed properties
    var areMoreCharacters: Bool {
        return infoList?.nextUrl != nil
    }
    
    var numberOfPage: Int {
        return (characters.count / 20) + 1
    }
    
    // MARK: - Private Properties
    
    // MARK: - Public functions
    func loadData() {
        fetchCharacterList()
    }
    
    func character(by index: Int) -> CharacterDAO? { characters[index] }
    
    func onUpdateData(withReset reset: Bool) {
        if reset {
            characters = []
        }
        
        fetchCharacterList()
    }
    
    func onCharacterPressed(_ index: Int) {
        showLocationDetail(for: index)
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
                print(error)
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
