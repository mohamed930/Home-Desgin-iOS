//
//  CollectionViewDelegate.swift
//  HomeCommercialApp
//
//  Created by Mohamed Ali on 16/09/2021.
//

import UIKit

extension ProductsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0 {
            return CGSize(width: self.HotCollectioView.frame.size.width , height: self.HotCollectioView.frame.size.height)
        }
        else if collectionView.tag == 1 {
            return CGSize(width: ((self.productsCollectionView.frame.size.width - 15) / 2), height: 400.0)
        }
        else {
            return CGSize(width: self.HotCollectioView.frame.size.width, height: self.HotCollectioView.frame.size.height / 2)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView.tag == 0 {
            return 0.0
        }
        else {
            return 10.0
        }
    }
    
}

extension ProductsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if collectionView.tag == 0 {
            Hotpagginbcontroller.currentPage = indexPath.row
        }
        
    }
}
