//
//  LocationDetailViewModel.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 27/03/2021.
//

import Foundation
import RxSwift

class LocationDetailViewModel {
    // MARK: - Observables
    let needReloadData : PublishSubject<Bool> = PublishSubject()
    
    // MARK: - Properties
    var lastLocation: CharacterLocationDAO?
    var locationData: LocationDAO?
    
    // MARK: - Computed properties
    
    // MARK: - Private Properties
    
    // MARK: - Public functions
    func loadData() {
        fetchLocationDetail()
    }
    
    // MARK: - Data functions
    /// Get all layouts for home
    fileprivate func fetchLocationDetail() {
        guard let urlLocation = lastLocation?.url else { return }
        
        let dataManager = DataManager.shared
        dataManager.fetchLocation(url: urlLocation) { (result) in
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
        guard let location = data as? LocationDAO else { return }
        locationData = location
    }
}
