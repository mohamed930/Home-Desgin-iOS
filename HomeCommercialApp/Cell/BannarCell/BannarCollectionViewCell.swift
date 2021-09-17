//
//  BannarCollectionViewCell.swift
//  HomeCommercialApp
//
//  Created by Mohamed Ali on 16/09/2021.
//

import UIKit

class BannarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var BannarImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func ConfigureCell(bannar: BannarModel) {
        BannarImageView.image = UIImage(named: bannar.BannarImageURL)
    }

}
