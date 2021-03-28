//
//  LocationInfoViewCell.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 27/03/2021.
//

import UIKit

class LocationInfoViewCell: UITableViewCell {
    // MARK: - Class
    static let cellIdentifier = String(describing: LocationInfoViewCell.self)
    static let estimatedHeight: CGFloat = 150.0
    
    // MARK: - IBOutlet
    @IBOutlet weak var mName: UILabel!
    @IBOutlet weak var mTypeTitle: UILabel!
    @IBOutlet weak var mType: UILabel!
    @IBOutlet weak var mDimensionTitle: UILabel!
    @IBOutlet weak var mDimension: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        mName.text = nil
        mTypeTitle.text = nil
        mType.text = nil
        mDimensionTitle.text = nil
        mDimension.text = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Configure methods
    func configure(with location: LocationDAO) {
        update(name: location.name)
        update(type: location.type)
        update(dimension: location.dimension)
    }
    
    // MARK: - Private methods
    private func update(name: String) {
        self.mName.text = name
    }
    
    private func update(type: String) {
        mTypeTitle.text = "Type:" // TODO: Change hardcode
        mType.text = type
    }
    
    private func update(dimension: String) {
        mDimensionTitle.text = "Dimension:" // TODO: Change hardcode
        mDimension.text = dimension
    }
}
