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
    let needShowAlert : PublishSubject<String> = PublishSubject()
    
    // MARK: - Properties
    var lastLocation: CharacterLocationDAO?
    var locationData: LocationDAO?
    
    // MARK: - Computed properties
    var numberOfRows: Int {
        guard locationData != nil else { return 0 }
        
        return 1
    }
    
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
                self.needShowAlert.onNext(error ?? NSLocalizedString("error_standar", comment: ""))
            }
        }
    }
    
    fileprivate func parseData(_ data: Any?) {
        guard let location = data as? LocationDAO else { return }
        locationData = location
    }
}
