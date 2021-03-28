//
//  CharacterDetailViewController.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 27/03/2021.
//

import Foundation
import RxSwift

protocol CharacterDetailViewDelegate {
    func needUpdate(characterId: Int?)
}

class CharacterDetailViewController: UIViewController {
    
    // MARK: - Public properties
    var character: CharacterDAO?
    var delegate: CharacterDetailViewDelegate? = nil
    
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
        
        viewModel.character = character
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
        
        viewModel.needNavigateTo
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (scene) in
                self?.navigateTo(scene)
            })
            .disposed(by: disposeBag)
        
        viewModel.needChangeFavorite
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.refreshDelegate()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Reaload Data
    private func reloadData() {
        tableView.reloadData()
    }
    
    // MARK: - Navigate functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Segue.characterDetailToLocationDetail.rawValue:
            guard let destination = segue.destination as? LocationDetailViewController else { return }
            destination.location = character?.location
            
        default:
            return
        }
    }
    
    private func navigateTo(_ scene: Scene) {
        switch scene {
        case .locationDetail:
            navigateTo(.characterDetailToLocationDetail)
            
        default:
            // TODO:
            break
        }
    }
    
    private func refreshDelegate() {
        delegate?.needUpdate(characterId: viewModel.character?.id ?? nil)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        self.tableView.deselectRow(at: indexPath, animated: false)
    }
    
    // MARK: Private
    // MARK: Configure cells
    private func cellInfo(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterInfoViewCell.cellIdentifier,
                                                 for: indexPath) as? CharacterInfoViewCell
        
        if let char = viewModel.character {
            cell?.configure(character: char) {
                // Notify ViewModel and make action
                self.viewModel.favoriteAction()
            }
        }
        
        return cell ?? UITableViewCell()
    }
    
    private func cellOrigin(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterOriginViewCell.cellIdentifier,
                                                 for: indexPath) as? CharacterOriginViewCell
        
        if let char = viewModel.character {
            cell?.configure(origin: char.origin)
        }
        
        return cell ?? UITableViewCell()
    }
    
    private func cellLocation(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterLocationViewCell.cellIdentifier,
                                                 for: indexPath) as? CharacterLocationViewCell
        
        if let char = viewModel.character {
            cell?.configure(location: char.location, action: {
                // Notify ViewModel and make action
                self.viewModel.locationAction()
            })
        }
        
        return cell ?? UITableViewCell()
    }
}

