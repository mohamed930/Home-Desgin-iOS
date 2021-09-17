//
//  productsCellCollectionViewDelegate.swift
//  HomeCommercialApp
//
//  Created by Mohamed Ali on 16/09/2021.
//

import UIKit

extension ProductsCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0 {
            return CGSize(width: self.BannarCollectionView.frame.size.width, height: self.BannarCollectionView.frame.size.height)
        }
        else {
            return CGSize(width: 45.0, height: 45.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView.tag == 0 {
            return 0.0
        }
        else {
            return 15.0
        }
    }
}

extension ProductsCollectionViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            self.PaggingController.currentPage = indexPath.row
        }
    }
}
