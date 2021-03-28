//
//  CharacterViewCell.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 27/03/2021.
//

import UIKit
import AlamofireImage

class CharacterViewCell: UITableViewCell {
    
    // MARK: - Class
    static let cellIdentifier = String(describing: CharacterViewCell.self)
    static let estimatedHeight: CGFloat = 100.0
    
    // MARK: - IBOutlet
    @IBOutlet weak var mImage: UIImageView!
    @IBOutlet weak var mName: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        mImage.image = nil
        mName.text = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Configure methods
    func configure(character: CharacterDAO) {
        update(imageUrl: character.image)
        update(name: character.name)
    }
    
    // MARK: - Private methods
    private func update(imageUrl: String) {
        let url = URL(string: imageUrl)!
        mImage.af.setImage(withURL: url)
    }
    
    private func update(name: String) {
        self.mName.text = name
    }
}
