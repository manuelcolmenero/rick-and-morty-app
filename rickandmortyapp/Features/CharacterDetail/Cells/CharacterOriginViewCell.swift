//
//  CharacterOriginViewCell.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 27/03/2021.
//

import UIKit

class CharacterOriginViewCell: UITableViewCell {
    
    // MARK: - Class
    static let cellIdentifier = String(describing: CharacterOriginViewCell.self)
    static let estimatedHeight: CGFloat = 75.0
    
    // MARK: - IBOutlet
    @IBOutlet weak var mTitle: UILabel!
    @IBOutlet weak var mName: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        mTitle.text = nil
        mName.text = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - Configure methods
    func configure(origin: CharacterOriginDAO) {
        
        update(name: origin.name)
    }
    
    // MARK: - Private methods
    private func update(name: String) {
        mTitle.text = "Origin location:" // TODO: Change hardcode
        
        mName.text = name
    }
    
}
