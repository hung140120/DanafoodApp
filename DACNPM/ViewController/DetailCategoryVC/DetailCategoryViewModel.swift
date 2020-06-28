//
//  DetailCategoryViewModel.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/22/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper

class DetailCategoryViewModel: MVVMViewModel {
    var product = ObjectManager.shared.product
    init() {
        
    }
}
//extension DetailCategoryViewModel {
//    func apiAll() {
//        Api.Product.all { [weak self] (result) in
//            //guard let this = self else { return }
//            result.isSuccess(completion: { (json) in
//                guard let json = json as? JSArray else { return }
//                let newProduct = Mapper<ProductObject>().mapArray(JSONArray: json)
//                self!.product.accept(newProduct)
//            }).error(completion: { (error) in
//                print(error)
//            })
//        }
//    }
//}
