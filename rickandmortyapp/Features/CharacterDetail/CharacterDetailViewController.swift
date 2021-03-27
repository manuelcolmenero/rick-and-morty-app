//
//  CharacterDetailViewController.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 27/03/2021.
//

import Foundation
import RxSwift

class CharacterDetailViewController: UIViewController {
    
    // MARK: - Public properties
    var character: CharacterDAO?
    
    // MARK: - Properties
    private let viewModel = CharacterDetailViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureObservers()
        configureView()
        
        viewModel.loadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = character?.name
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
extension CharacterDetailViewController : UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Configure
    func configureTableView() {
        tableView.register(UINib(nibName: CharacterInfoViewCell.cellIdentifier,
                                 bundle: nil),
                           forCellReuseIdentifier: CharacterInfoViewCell.cellIdentifier)
        
        tableView.register(UINib(nibName: CharacterOriginViewCell.cellIdentifier,
                                 bundle: nil),
                           forCellReuseIdentifier: CharacterOriginViewCell.cellIdentifier)
        
        tableView.register(UINib(nibName: CharacterLocationViewCell.cellIdentifier,
                                 bundle: nil),
                           forCellReuseIdentifier: CharacterLocationViewCell.cellIdentifier)
        
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return CharacterInfoViewCell.estimatedHeight
        case 1:
            return CharacterOriginViewCell.estimatedHeight
        default:
            return CharacterLocationViewCell.estimatedHeight
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return cellInfo(for: indexPath)
        case 1:
            return cellOrigin(for: indexPath)
        default:
            return cellLocation(for: indexPath)
        }
    }
    
    // MARK: Private
    // MARK: Configure cells
    private func cellInfo(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterInfoViewCell.cellIdentifier,
                                                 for: indexPath) as? CharacterInfoViewCell
        
        if let char = character {
            cell?.configure(character: char)
        }
        
        return cell ?? UITableViewCell()
    }
    
    private func cellOrigin(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterOriginViewCell.cellIdentifier,
                                                 for: indexPath) as? CharacterOriginViewCell
        
        if let char = character {
            cell?.configure(origin: char.origin)
        }
        
        return cell ?? UITableViewCell()
    }
    
    private func cellLocation(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterLocationViewCell.cellIdentifier,
                                                 for: indexPath) as? CharacterLocationViewCell
        
        if let char = character {
            cell?.configure(location: char.location, action: {
                // Notify ViewModel and make action
                self.viewModel.sendButtonAction()
            })
        }
        
        return cell ?? UITableViewCell()
    }
}

