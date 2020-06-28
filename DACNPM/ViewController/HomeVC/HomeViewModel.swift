//
//  HomeViewModel.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/21/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper

class HomeViewModel: MVVMViewModel {
    var posts = ObjectManager.shared.post
    init() {
        apiAllProduct()
    }
}
extension HomeViewModel {
    func apiAllProduct() {
        UIHelper.showLoading()
        Api.Post.all { (result) in
            result.isSuccess(completion: { (json) in
                UIHelper.hideLoading()
                guard let json = json as? JSArray else { return }
                let newProduct = Mapper<PostObject>().mapArray(JSONArray: json)
                self.posts.accept(newProduct)
            }).error(completion: { (error) in
                print(error)
            })
        }
    }
}
