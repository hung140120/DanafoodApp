//
//  CategoryViewModel.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/21/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper

class CategoryViewModel: MVVMViewModel {
    var productCategory = ObjectManager.shared.productCategory
    var products = ObjectManager.shared.product
    var categories = [Int]()
    init() {
        apiAll()
        apiAllProduct()
    }
}
extension CategoryViewModel {
    func apiAll() {
        //UIHelper.showLoading()
        Api.ProductCategory.all { [weak self] (result) in
            //guard let this = self else { return }
            result.isSuccess(completion: { (json) in
                //UIHelper.hideLoading()
                guard let json = json as? JSArray else { return }
                let newCategories = Mapper<ProductCategoryObject>().mapArray(JSONArray: json)
                self?.categories = Mapper<ProductCategoryObject>().mapArray(JSONArray: json).map({$0.ID})
                self?.categories.removeDuplicates()
                self?.categories.sort()
                self!.productCategory.accept(newCategories)
            }).error(completion: { (error) in
                print(error)
            })
        }
    }
    
    func apiAllProduct() {
        Api.Product.all { [weak self] (result) in
            result.isSuccess(completion: { (json) in
                guard let json = json as? JSArray else { return }
                let newProduct = Mapper<ProductObject>().mapArray(JSONArray: json)
                
                self?.products.accept(newProduct)
            }).error(completion: { (error) in
                print(error)
            })
        }
    }
}
