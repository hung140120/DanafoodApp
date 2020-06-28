//
//  API.ResultXoso.swift
//  XoSo
//
//  Created by Dinh Hung on 4/15/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension Api.Auth {

    @discardableResult
    static func phoneLogin(phone: String, password: String, completion: @escaping ServiceCompletion) -> Request? {
        let path = Api.Path.Auth.loginWithPhone
        let param = ["grant_type": "password", "Username": phone, "Password": password]
//        return api.request(method: .post, urlString: path, parameters: param.toJSON()) { (result) in
//            DispatchQueue.main.async {
//                completion(result)
//            }
//        }
        return Alamofire.request(path,method: .post, parameters: param)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
                DispatchQueue.main.async {
                    completion(response.result)
            }
        }
    }
    
//    @discardableResult
//    static func register(phone: String, password: String, name: String, email: String, address: String, completion: @escaping ServiceCompletion) -> Request? {
//            let path = Api.Path.Auth.loginWithPhone
//            let param = ["grant_type": "password", "Username": phone, "Password": password]
//    //        return api.request(method: .post, urlString: path, parameters: param.toJSON()) { (result) in
//    //            DispatchQueue.main.async {
//    //                completion(result)
//    //            }
//    //        }
//            return Alamofire.request(path,method: .post, parameters: param)
//                .validate(contentType: ["application/json"])
//                .responseJSON { (response) in
//                    DispatchQueue.main.async {
//                        completion(response.result)
//                }
//            }
//        }
    
    
    
    struct RegisterParam {
        var name: String = ""
        var phone: String = ""
        var password: String = ""
        var email: String = ""
        var address: String = ""
        var birthday: String = ""
        
        
        func toJSON() -> JSObject {
            var param = JSObject()
            
            param["FullName"] = name
            param["PhoneNumber"] = phone
            param["Password"] = password
            param["Email"] = email
            param["Address"] = address
            param["BirthDay"] = birthday
            return param
        }
    }
    @discardableResult
    static func register(param: RegisterParam, completion: @escaping ServiceCompletion) -> Request? {
        let path = Api.Path.Auth.register
        return api.request(method: .post, urlString: path, parameters: param.toJSON()) { (result) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    struct UpdateParam {
        var phone: String = ""
        var name: String = ""
        var password: String = ""
        var address: String = ""
        var birthday: String = ""
        
        
        func toJSON() -> JSObject {
            var param = JSObject()
            
            param["PhoneNumber"] = phone
            param["FullName"] = name
            param["Email"] = UDKey.User.email.value
            param["Password"] = password
            param["Address"] = address
            param["BirthDay"] = birthday
            return param
        }
    }
    @discardableResult
    static func UpdateUser(param: UpdateParam, completion: @escaping ServiceCompletion) -> Request? {
        let path = Api.Path.Auth.updateUser
        let bearer = "bearer "
        let token = UDKey.User.token.value ?? ""
        return api.request(method: .put, urlString: path, parameters: param.toJSON(), headers: ["Authorization" : bearer + token]) { (result) in
            print(param)
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
