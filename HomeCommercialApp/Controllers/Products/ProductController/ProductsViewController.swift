//
//  ProductsViewController.swift
//  HomeCommercialApp
//
//  Created by Mohamed Ali on 16/09/2021.
//

import UIKit
import RxSwift
import RxCocoa

class ProductsViewController: UIViewController {
    
    @IBOutlet weak var HotCollectioView: UICollectionView!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var Hotpagginbcontroller: UIPageControl!
    
    let BannarNibFile = "BannarCollectionViewCell"
    let productsNibFile = "ProductsCollectionViewCell"
    let CellIdentifier = "Cell"
    let productviewmodel = ProductViewModel()
    let disposebag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ConfigureCell()
        BindToCollectionView()
        GetBannarData()
        
        startMoving()
        
        GetProductsData()
        ConfigureProductsCollectioView()
        BindToProductsCollectionView()
    }
    
    
    func ConfigureCell() {
        HotCollectioView.delegate = self
        HotCollectioView.register(UINib(nibName: BannarNibFile, bundle: nil), forCellWithReuseIdentifier: CellIdentifier)
        Hotpagginbcontroller.numberOfPages = productviewmodel.numberofPagesBehaviour.value
    }
    
    func BindToCollectionView() {
        productviewmodel.BannarsObservable.asObservable().bind(to: HotCollectioView.rx.items(cellIdentifier: CellIdentifier, cellType: BannarCollectionViewCell.self)) { row, branch, cell in
            
            cell.ConfigureCell(bannar: branch)
            
        }.disposed(by: disposebag)
    }

    func GetBannarData() {
        productviewmodel.GetImagesOperation()
    }
    
    func startMoving() {
        _ = Timer.scheduledTimer(timeInterval: 2.5, target: self,selector: #selector(self.scrollAutomatically),userInfo: nil,repeats: true)
    }
    
    
    @objc func scrollAutomatically(_ timer1: Timer) {
        if let coll = HotCollectioView {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                let count = productviewmodel.numberofPagesBehaviour.value
                if((indexPath?.row)! < count - 1) {
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                    
                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                }
                else {
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                    
                }
            }
        }
    }
    
    
    func ConfigureProductsCollectioView() {
        productsCollectionView.delegate = self
        productsCollectionView.register(UINib(nibName: productsNibFile, bundle: nil), forCellWithReuseIdentifier: CellIdentifier)
    }
    
    func BindToProductsCollectionView() {
        productviewmodel.ProductsBehaviour.bind(to: productsCollectionView.rx.items(cellIdentifier: CellIdentifier, cellType: ProductsCollectionViewCell.self)) { [weak self] row , branch , cell in
            
            guard let self = self else { return }
            
            cell.ConfigureCell(product: branch)
//            cell.AddToCartButton.tag = row
//            cell.AddToCartButton.addTarget(self, action: #selector(self.AddCartButtonAction), for: .touchUpInside)
            
            cell.AddToCartButton.rx.tap.throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance).subscribe(onNext: { _ in
                
                let indexpath = IndexPath.init(row: row, section: 0)
                let cell = self.productsCollectionView.cellForItem(at: indexpath) as! ProductsCollectionViewCell
                
                guard let pickedSize = cell.pickedSize else {
                    print("No Added to Cart")
                    return
                }
                
                print("FAction: \(pickedSize)")
                
                var arr = self.productviewmodel.ProductsBehaviour.value
                arr[indexpath.row].AddedStatus = true
                
                cell.AddToCartButton.isEnabled = false
                cell.AddToCartButton.backgroundColor = UIColor.red
                
                self.createAlert(Title: "Success", Mess: "Product added to cart")
                
            }).disposed(by: self.disposebag)
            
        }.disposed(by: disposebag)
    }
    
    
    func GetProductsData() {
        productviewmodel.GetProductsOperation()
    }
    
    private func createAlert (Title:String , Mess:String) {
        let alert = UIAlertController(title: Title , message: Mess, preferredStyle:.alert)
        alert.addAction(UIAlertAction(title:"OK",style:.default,handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
        self.present(alert,animated:true,completion: nil)
    }

}

