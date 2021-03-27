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
    private let viewModel = LocationDetailViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - IBOutlet
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.lastLocation = location
        viewModel.loadData()
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
        viewModel.needReloadData
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                self?.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Reaload Data
    private func reloadData() {
        
    }
}
