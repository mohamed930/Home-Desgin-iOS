//
//  ProductsCollectionViewCell.swift
//  HomeCommercialApp
//
//  Created by Mohamed Ali on 16/09/2021.
//

import UIKit
import RxSwift
import RxRelay

class ProductsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var BannarCollectionView: UICollectionView!
    @IBOutlet weak var PaggingController: UIPageControl!
    @IBOutlet weak var ProductNameLabel: UILabel!
    @IBOutlet weak var ProductPriceLabel: UILabel!
    @IBOutlet weak var SizeCollectionView: UICollectionView!
    @IBOutlet weak var AddToCartButton: UIButton!
    @IBOutlet weak var View: UIView!
    
    
    let BannarNibFile = "BannarCollectionViewCell"
    let sizesNibFile = "SizeCollectionViewCell"
    let CellIdentifier = "Cell"
    let disposebag = DisposeBag()
    var pickedSize: String?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        SetButtonConfigure()
        ConfigureBackgroundView()
    }
    
    func ConfigureCell(product: ProductModel) {
        ProductNameLabel.text = product.ProductName
        ProductPriceLabel.text = product.ProcutPrice + "$"
        
        AddToCartButton.isEnabled = product.AddedStatus == true ? false : true
        AddToCartButton.backgroundColor = product.AddedStatus ? UIColor.red : UIColor.link
        
        ConfigureBannarCollectionView(product: product)
        
        ConfigureSizeCollectionView(product: product)
    }
    
    private func SetButtonConfigure() {
        AddToCartButton.layer.cornerRadius = 5.0
        AddToCartButton.layer.masksToBounds = true
    }
    
    private func ConfigureBackgroundView() {
        View.layer.cornerRadius = 5.0
        View.layer.masksToBounds = true
        View.layer.borderColor = UIColor.gray.cgColor
        View.layer.borderWidth = 0.5
    }
    
    private func ConfigureBannarCollectionView(product: ProductModel) {
        BannarCollectionView.delegate = self
        BannarCollectionView.register(UINib(nibName: BannarNibFile, bundle: nil), forCellWithReuseIdentifier: CellIdentifier)
        
        PaggingController.numberOfPages = product.Images.count
        
        let ImagesBehaviour = BehaviorRelay<[String]>(value: [])
        ImagesBehaviour.accept(product.Images)
        
        ImagesBehaviour.bind(to: BannarCollectionView.rx.items(cellIdentifier: CellIdentifier, cellType: BannarCollectionViewCell.self)) { row, branch, cell in
            cell.BannarImageView.image = UIImage(named: branch)
        }.disposed(by: disposebag)
        
    }
    
    
    private func ConfigureSizeCollectionView(product: ProductModel) {
        SizeCollectionView.delegate = self
        SizeCollectionView.register(UINib(nibName: sizesNibFile, bundle: nil), forCellWithReuseIdentifier: CellIdentifier)
        
        let SizesBehaviour = BehaviorRelay<[SizeModel]>(value: [])
        var sizes = Array<SizeModel>()
        for i in product.ProductSize {
            let ob = SizeModel(SizeNumber: i, Selected: false)
            sizes.append(ob)
        }
        SizesBehaviour.accept(sizes)
        
        SizesBehaviour.bind(to: SizeCollectionView.rx.items(cellIdentifier: CellIdentifier, cellType: SizeCollectionViewCell.self)) { row, branch, cell in
            cell.ConfigureCell(size: branch)
            
        }.disposed(by: disposebag)
        
        Observable.zip(SizeCollectionView.rx.itemSelected, SizeCollectionView.rx.modelSelected(SizeModel.self))
            .bind { selectedIndex, branch in

                var NewArr = Array<SizeModel>()
                
                for i in SizesBehaviour.value {
                    if i.SizeNumber == branch.SizeNumber {
                        if i.Selected == true {
                            let ob = SizeModel(SizeNumber: i.SizeNumber, Selected: false)
                            NewArr.append(ob)
                        }
                        else {
                            let ob = SizeModel(SizeNumber: i.SizeNumber, Selected: true)
                            self.pickedSize = ob.SizeNumber
                            NewArr.append(ob)
                        }
                        
                    }
                    else {
                        let ob = SizeModel(SizeNumber: i.SizeNumber, Selected: false)
                        NewArr.append(ob)
                    }
                }
                
                SizesBehaviour.accept(NewArr)
        }
        .disposed(by: disposebag)
        
    }
}
