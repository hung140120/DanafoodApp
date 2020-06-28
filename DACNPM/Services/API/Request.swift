//
//  Request.swift
//  ZoTV
//
//  Created by TruongVO07 on 5/8/18.
//  Copyright © 2018 mentalstack. All rights reserved.
//

import Foundation
import Alamofire

extension ApiManager {
    
    @discardableResult
    func request(method: HTTPMethod,
                 urlString: URLStringConvertible,
                 parameters: [String: Any]? = nil,
                 headers: [String: String]? = nil,
                 completion: ServiceCompletion?) -> Request? {
        
        guard Network.share.isReachable else {
            completion?(.failure(Api.Error.network))
            return nil
        }
        
        let encoding: ParameterEncoding
        if method == .post || method == .put {
            encoding = JSONEncoding.default
        } else {
            encoding = URLEncoding.default
        }
        
        var headers_ = api.defaultHTTPHeader
        headers_.updateValues(headers)
        //print(headers_)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let request = Alamofire
            .request(urlString.urlString, method: method, parameters: parameters, encoding: encoding, headers: headers_)
        let dataRequest = request.responseJSON(completion: { (response) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
                completion?(response.result)
            })
        return dataRequest
    }
    
    func upload(method: HTTPMethod,
                urlString: URLStringConvertible,
                imageData: [Data],
                name: String = "image_data[]",
                param: JSObject?,
                progress: ((Double) -> Void)?,
                completion: ServiceCompletion?) {
        let headers_ = api.defaultHTTPHeader
        Alamofire.upload(multipartFormData: { (form) in
            for image in imageData {
                form.append(image, withName: name, fileName: "productImage_\(Date().timeIntervalSince1970).png", mimeType: "image/png")
            }
            if let parameters = param {
                for (key, value) in parameters {
                    form.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false)!, withName: key)
                }
            }
        }, to: urlString.urlString, method: method, headers: headers_) { (result) in
            switch result {
            case .success(let request, _, _):
                request.responseJSON(completion: { (response) in
                    completion?(response.result)
                })
                request.uploadProgress(closure: { (gg) in
                    progress?(gg.fractionCompleted)
                })
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
}
