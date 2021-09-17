//
//  ProductViewModel.swift
//  HomeCommercialApp
//
//  Created by Mohamed Ali on 16/09/2021.
//

import Foundation
import RxSwift
import RxCocoa

class ProductViewModel {
    
    var numberofPagesBehaviour = BehaviorRelay<Int>(value: 0)
    
    private var BannarsBehaviour = ReplaySubject<[BannarModel]>.createUnbounded()
    var BannarsObservable: Observable<[BannarModel]> {
        return BannarsBehaviour
    }
    
    var ProductsBehaviour = BehaviorRelay<[ProductModel]>(value: [])
    
    
    func GetImagesOperation() {
        
        let dic = ["1":"1","2":"2","3":"3","4":"4"]
        
        var arr = Array<BannarModel>()
        
        for (k,v) in dic {
            let bannar = BannarModel(id: k, BannarImageURL: v)
            arr.append(bannar)
            arr.sort(by: {Int($0.id)! < Int($1.id)!})
        }
        
        numberofPagesBehaviour.accept(arr.count)
        BannarsBehaviour.onNext(arr)
        BannarsBehaviour.onCompleted()
        
    }
    
    func GetProductsOperation() {
        
        var products = Array<ProductModel>()
        
        let product = ProductModel(Images: ["a1","a2","a3","a4","a5"], ProductName: "Active Shoe Sport 1", ProcutPrice: "100", ProductSize: ["38","40","42","43","44","45","46"], AddedStatus: false)
        products.append(product)
        
        
        let product1 = ProductModel(Images: ["b1","b2","b3","b4","b5"], ProductName: "Active Shoe Sport X3", ProcutPrice: "130", ProductSize: ["38","40","42","43","44","45","46"], AddedStatus: false)
        products.append(product1)
        
        let product2 = ProductModel(Images: ["c1","c2"], ProductName: "Active Shoe Sport Ye22", ProcutPrice: "60", ProductSize: ["38","40","42","43","44","45","46"], AddedStatus: false)
        products.append(product2)
        
        let product3 = ProductModel(Images: ["d1"], ProductName: "Active Shoe Sport 5", ProcutPrice: "300", ProductSize: ["42","43","44","45","46"], AddedStatus: false)
        products.append(product3)
        
        
        ProductsBehaviour.accept(products)
        
    }
    
    
}
