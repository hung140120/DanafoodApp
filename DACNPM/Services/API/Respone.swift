//
//  Respone.swift
//  XoSo
//
//  Created by Dinh Hung on 4/21/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import Alamofire

extension Request {
    static func responseJSON(log: Bool = true,
                             response: HTTPURLResponse?,
                             data: Data?,
                             error: Error?) -> Result<Any> {
        guard let response = response else {
            return .failure(NSError(status: .noResponse))
        }
        
        //print("")
        if log {
//            print("API->URL: \(response.url?.absoluteString ?? "")")
//            print("API->Header: \(response.allHeaderFields)")
        }
        
        if let error = error {
            return .failure(error)
        }
        
        let statusCode = response.statusCode
        if 204...205 ~= statusCode {
            return .success([:])
        }
        
        guard 200...299 ~= statusCode else {
//            if statusCode == 401 {
//                DispatchQueue.main.async {
//                    AppDelegate.share.logout()
//                }
//            }
//
            var err: NSError!
            var json = data?.toJSON()
            if let json = json as? JSArray {
                if let first = json.first {
                    var ms = "Đã có lỗi xảy ra, có thể 1 thiết bị khác đang đăng nhập tài khoản của bạn!!!"
                    if let message = first["message"] as? String {
                        ms = message
                    }
                    err = NSError(message: ms)
                }
            } else if let status = HTTPStatus(code: statusCode) {
                err = NSError(domain: Api.Path.baseURL.host, status: status)
            } else {
                err = NSError(domain: Api.Path.baseURL.host,
                              code: statusCode,
                              message: "Unknown HTTP status code received (\(statusCode)).")
            }
            if log {
                //print("API->ERROR 1:=> \(statusCode) <---> \(err.localizedDescription)")
            }
            print("")
            return .failure(err)
            
        }
        
        guard let data = data, var json = data.toJSON() else {
            let err = Api.Error.json
            if log {
                //print("API->ERROR 2:=> \(statusCode) <---> \(err.localizedDescription)")
            }
            print("")
            return .failure(Api.Error.json)
        }
        
        if let json = json as? JSObject {
//            print("API->Success: Data is a Object")
//            print("")
            if log {
                //print(json)
            }
            return .success(json as Any)
        }
        
        if let arr = json as? JSArray {
//            print("API->Success: Data is a Array(\(arr.count) item)")
//            print("")
            if log {
                //print(json)
            }
            return .success(arr as Any)
        }
        
        //
        let msg = "Dữ liệu không đúng định dạng."
        let err = NSError(message: msg)
        if log {
            //print("API->ERROR 4:=> -- <---> \(msg)")
        }
        //print("")
        return .failure(err)
    }
}


extension DataRequest {
    static func response() -> DataResponseSerializer<Any> {
        return DataResponseSerializer {_, response, data, error in
            return Request.responseJSON(log: true, response: response, data: data, error: error)
        }
    }
    
    @discardableResult
    func responseJSON(queue: DispatchQueue = .global(qos: .background),
                      completion: @escaping (DataResponse<Any>) -> Void) -> Self {
        return response(queue: queue,
                        responseSerializer: DataRequest.response(),
                        completionHandler: completion)
    }
}
