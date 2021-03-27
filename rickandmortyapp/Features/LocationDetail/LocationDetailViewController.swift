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
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureObservers()
        configureView()
        
        viewModel.lastLocation = location
        viewModel.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = location?.name
    }
    
    // MARK: - Configure methods
    private func configureView() {
        configureTableView()
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
        tableView.reloadData()
    }
}

// MARK: - TableView Delegate-DataSource
extension LocationDetailViewController : UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Configure
    func configureTableView() {
        tableView.register(UINib(nibName: LocationInfoViewCell.cellIdentifier,
                                 bundle: nil),
                           forCellReuseIdentifier: LocationInfoViewCell.cellIdentifier)
        
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return LocationInfoViewCell.estimatedHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellInfo(for: indexPath)
    }
    
    // MARK: Private
    // MARK: Configure cells
    private func cellInfo(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationInfoViewCell.cellIdentifier,
                                                 for: indexPath) as? LocationInfoViewCell
        
        if let location = viewModel.locationData {
            cell?.configure(with: location)
        }
        
        return cell ?? UITableViewCell()
    }
}
