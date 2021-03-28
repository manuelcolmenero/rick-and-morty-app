//
//  CharacterInfoViewCell.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 27/03/2021.
//

import UIKit
import AlamofireImage

class CharacterInfoViewCell: UITableViewCell {
    
    // MARK: - Class
    static let cellIdentifier = String(describing: CharacterInfoViewCell.self)
    static let estimatedHeight: CGFloat = 150.0
    
    // MARK: - IBOutlet
    @IBOutlet weak var mImage: UIImageView!
    @IBOutlet weak var mName: UILabel!
    @IBOutlet weak var mStatus: UILabel!
    @IBOutlet weak var mSpecies: UILabel!
    @IBOutlet weak var mFavorite: UIButton!
    
    
    // MARK: - IBAction
    @IBAction func mFavoriteAction(_ sender: Any) {
        favoriteActionDelegate?()
    }
    
    // MARK: - Private properties
    private var favoriteActionDelegate: VoidBlock? = nil
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        mImage.image = nil
        mName.text = nil
        mStatus.text = nil
        mSpecies.text = nil
        mFavorite.setTitle(nil, for: .normal)
        mFavorite.setImage(nil, for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Configure methods
    func configure(character: CharacterDAO, action: VoidBlock? = nil) {
        favoriteActionDelegate = action
        
        update(imageUrl: character.image)
        update(name: character.name)
        update(status: character.status)
        update(species: character.species, gender: character.gender)
        update(favorite: character.favorite)
    }
    
    // MARK: - Private methods
    private func update(imageUrl: String) {
        let url = URL(string: imageUrl)!
        mImage.af.setImage(withURL: url)
    }
    
    private func update(name: String) {
        mName.text = name
    }
    
    private func update(status: String) {
        mStatus.text = "status: \(status)" // TODO: Change hardcode
    }
    
    private func update(species: String, gender: String) {
        mSpecies.text = "\(species) - \(gender)"
    }
    
    private func update(favorite: Bool) {
        if favorite {
            mFavorite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            mFavorite.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
}
