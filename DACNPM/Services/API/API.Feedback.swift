//
//  API.Feedback.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/27/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import Alamofire

extension Api.Feedback {
    struct FeedbackParam {
        var name : String = ""
        var email : String = ""
        var message : String = ""
        
        func toJSON() -> JSObject {
            var param = JSObject()
            param["Name"] = name
            param["Email"] = email
            param["Message"] = message
            return param
        }
    }
    @discardableResult
    static func Feedback(param: FeedbackParam, completion: @escaping ServiceCompletion) -> Request? {
        let path = Api.Path.FeedBack.feedback
        return api.request(method: .post, urlString: path, parameters: param.toJSON()) { (result) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
