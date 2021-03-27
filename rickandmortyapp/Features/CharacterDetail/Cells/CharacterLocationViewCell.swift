//
//  CharacterLocationViewCell.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 27/03/2021.
//

import UIKit

class CharacterLocationViewCell: UITableViewCell {
    
    // MARK: - Class
    static let cellIdentifier = String(describing: CharacterLocationViewCell.self)
    static let estimatedHeight: CGFloat = 100.0
    
    // MARK: - IBOutlet
    @IBOutlet weak var name: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        name.text = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Configure methods
    func configure(character: CharacterDAO) {
        update(name: character.location.name)
    }
    
    // MARK: - Private methods
    private func update(name: String) {
        self.name.text = name
    }
    
}
