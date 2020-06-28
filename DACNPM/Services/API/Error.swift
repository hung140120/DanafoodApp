//
//  Error.swift
//  XoSo
//
//  Created by Dinh Hung on 4/21/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import Alamofire

extension Api {
    struct Error {
        static let network = NSError(domain: NSCocoaErrorDomain, message: "Không có kết nối mạng.")
        static let authen = NSError(domain: Api.Path.baseURL.host, status: HTTPStatus.unauthorized)
        static let json = NSError(domain: NSCocoaErrorDomain, code: 3_840, message: "The operation couldn’t be completed.")
        static let apiKey = NSError(domain: Api.Path.baseURL.host, status: HTTPStatus.badRequest)
    }
    
}
