//
//  API.ProductCategory.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/21/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import Alamofire

extension Api.ProductCategory {
    @discardableResult
    static func all(completion: @escaping ServiceCompletion) -> Request? {
        let path = Api.Path.ProductCategory.all
        return api.request(method: .get, urlString: path) { (result) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
