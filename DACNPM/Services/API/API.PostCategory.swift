//
//  API.PostCategory.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/17/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import Alamofire

extension Api.Post {
    @discardableResult
    static func all(completion: @escaping ServiceCompletion) -> Request? {
        let path = Api.Path.Post.all
        return api.request(method: .get, urlString: path) { (result) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    @discardableResult
    func detail(completion: @escaping ServiceCompletion) -> Request? {
        let path = Api.Path.Post(id: self.id).detail
        return api.request(method: .get, urlString: path) { (result) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
