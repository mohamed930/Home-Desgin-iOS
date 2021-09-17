//
//  SizeCollectionViewCell.swift
//  HomeCommercialApp
//
//  Created by Mohamed Ali on 16/09/2021.
//

import UIKit

class SizeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var SizeLabel: UILabel!
    @IBOutlet weak var View: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        View.layer.cornerRadius = 10.0
        View.layer.masksToBounds = true
        
    }
    
    
    func ConfigureCell(size: SizeModel) {
        SizeLabel.text = size.SizeNumber
        
        if size.Selected {
            View.backgroundColor = UIColor.link
            SizeLabel.textColor = UIColor.white
        }
        else {
            View.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
            SizeLabel.textColor = UIColor.black
        }
    }
}
