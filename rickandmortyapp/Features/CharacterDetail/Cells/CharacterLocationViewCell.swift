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
    static let estimatedHeight: CGFloat = 125.0
    
    // MARK: - IBOutlet
    @IBOutlet weak var mTitle: UILabel!
    @IBOutlet weak var mName: UILabel!
    @IBOutlet weak var mLocationAction: UIButton!
    
    // MARK: - IBAction
    @IBAction func mBookDetailAction(_ sender: Any) {
        locationActionDelegate?()
    }
    
    // MARK: - Private properties
    private var locationActionDelegate: VoidBlock? = nil
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        mTitle.text = nil
        mName.text = nil
        mLocationAction.setTitle(nil, for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - Configure methods
    func configure(location: CharacterLocationDAO, type: LocationTypes, action: VoidBlock? = nil) {
        locationActionDelegate = action
        
        update(name: location.name, type: type)
        updateButton(url: location.url)
    }
    
    // MARK: - Private methods
    private func update(name: String, type: LocationTypes) {
        switch type {
        case .origin:
            mTitle.text = NSLocalizedString("character_title_origin", comment: "")
        case .last:
            mTitle.text = NSLocalizedString("character_title_last_location", comment: "")
        }
        
        mName.text = name
    }
    
    private func updateButton(url: String) {
        mLocationAction.isHidden = true
        
        if !url.isEmpty {
            mLocationAction.isHidden = false
            self.mLocationAction.setTitle(NSLocalizedString("character_button_location", comment: ""), for: .normal)
        }
    }    
}
