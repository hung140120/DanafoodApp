//
//  SearchViewModel.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/24/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper

class SearchViewModel: MVVMViewModel {
    var products = BehaviorRelay<[ProductObject]>(value: [])
    init() {
        apiAllProduct()
    }
}
extension SearchViewModel {
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
