//
//  API.Product.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/22/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import Alamofire

extension Api.Product {
    @discardableResult
    static func all(completion: @escaping ServiceCompletion) -> Request? {
        let path = Api.Path.Product.all
        return api.request(method: .get, urlString: path) { (result) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func byCategory(completion: @escaping ServiceCompletion) -> Request? {
        let path = Api.Path.Product(id: self.id).byCategory
        return api.request(method: .get, urlString: path) { (result) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    @discardableResult
    func detail(completion: @escaping ServiceCompletion) -> Request? {
        let path = Api.Path.Product(id: self.id).detail
        return api.request(method: .get, urlString: path) { (result) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
