//
//  CharacterInfoViewCell.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 27/03/2021.
//

import UIKit

class CharacterInfoViewCell: UITableViewCell {
    
    // MARK: - Class
    static let cellIdentifier = String(describing: CharacterInfoViewCell.self)
    static let estimatedHeight: CGFloat = 150.0
    
    // MARK: - IBOutlet
    @IBOutlet weak var mName: UILabel!
    @IBOutlet weak var mStatus: UILabel!
    @IBOutlet weak var mSpecies: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        mName.text = nil
        mStatus.text = nil
        mSpecies.text = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Configure methods
    func configure(character: CharacterDAO) {
        update(name: character.name)
        update(status: character.status)
        update(species: character.species, gender: character.gender)
    }
    
    // MARK: - Private methods
    private func update(name: String) {
        mName.text = name
    }
    
    private func update(status: String) {
        mStatus.text = "status: \(status)"
    }
    
    private func update(species: String, gender: String) {
        mSpecies.text = "\(species) - \(gender)"
    }
}
