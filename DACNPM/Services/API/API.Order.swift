//
//  API.Order.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/27/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import Alamofire

extension Api.Order {
    struct OrderParam {
        var dataOrder : [String : Any] = [:]
        var dataOrderDetails : [[String : Any]] = [[:]]
        
        func toJSON() -> JSObject {
            var param = JSObject()
            param["Order"] = dataOrder
            param["OrderDetails"] = dataOrderDetails
            return param
        }
    }
    @discardableResult
    static func order(param: OrderParam, completion: @escaping ServiceCompletion) -> Request? {
        let path = Api.Path.Order.order
        let bearer = "bearer "
        let token = UDKey.User.token.value ?? ""
        return api.request(method: .post, urlString: path, parameters: param.toJSON(), headers: ["Authorization" : bearer + token]) { (result) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
