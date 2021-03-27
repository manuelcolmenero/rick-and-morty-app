//
//  HomeViewController.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 27/03/2021.
//

import Foundation
import RxSwift

class HomeViewController: UIViewController {
    // MARK: - Properties
    private let viewModel = HomeViewModel()
    private let disposeBag = DisposeBag()
    
    private static let loadStartAt = 5
    private var isLoadingCharacters: Bool = false
    
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
        
        self.title = "Characters" // TODO: Change hardcode
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
        isLoadingCharacters = false
        tableView.reloadData()
    }
}


// MARK: - TableView Delegate-DataSource
extension HomeViewController : UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Configure
    func configureTableView() {
        tableView.register(UINib(nibName: CharacterViewCell.cellIdentifier,
                                      bundle: nil),
                           forCellReuseIdentifier: CharacterViewCell.cellIdentifier)
        
        tableView.register(UINib(nibName: LoadingViewCell.cellIdentifier,
                                 bundle: nil),
                           forCellReuseIdentifier: LoadingViewCell.cellIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        if(viewModel.areMoreCharacters && indexPath.row == viewModel.characters.count) {
            cell = cellLoading(tableView, cellForItemAt: indexPath)
        } else {
            cell = cellCharacter(tableView, cellForItemAt: indexPath)
        }
        
        loadMoreData(for: indexPath)
        return cell ?? UITableViewCell()
    }
    
    // MARK: Private
    // MARK: Configure cells
    private func cellLoading(_ tableView: UITableView, cellForItemAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: LoadingViewCell.cellIdentifier,
                                      for: indexPath)
    }
    
    private func cellCharacter(_ tableView: UITableView, cellForItemAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterViewCell.cellIdentifier,
                                                 for: indexPath) as? CharacterViewCell
        
        if let character = viewModel.character(by: indexPath.row) {
            cell?.configure(character: character)
        }
        
        return cell ?? UITableViewCell()
    }
    
    // MARK: Data functions
    private func loadMoreData(for indexPath: IndexPath) {
        if(!isLoadingCharacters && viewModel.areMoreCharacters && (viewModel.characters.count - indexPath.row) < HomeViewController.loadStartAt) {
            isLoadingCharacters = true
            viewModel.onUpdateData(withReset: false)
        }
    }
}
