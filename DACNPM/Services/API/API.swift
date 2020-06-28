//
//  API.swift
//  XoSo
//
//  Created by Dinh Hung on 4/21/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import Alamofire

typealias Network = NetworkReachabilityManager
var int = 1
let configServer: EndPoint = .dev

// MARK: - Network
extension Network {
    static let share: Network = {
        guard let manager = Network() else {
            fatalError("Cannot alloc network reachability manager!")
        }
        return manager
    }()
}

enum EndPoint: String {
    case pro = "http://52.221.180.139"
    case dev = "https://danafoodapp.azurewebsites.net"
}

final class Api {
    struct Path {
        static let baseURL = configServer.rawValue
    }
    
    // MARK: - Services properties define
    struct Auth {}
    struct ProductCategory {}
    struct Product {
        var id: Int
    }
    struct Post {
        var id: Int
    }
    struct Order {}
    struct Feedback {}
}

extension Api.Path {
    struct Auth: ApiPath {
        static var path: String { return baseURL }
        var urlString: String { return Auth.path }
        
        static var register: String { return path / "api" / "account" / "register" }
        static var loginWithPhone: String { return path / "token" }
        static var updateUser: String {return path / "api" / "account" / "update" }
    }
    
    struct ProductCategory: ApiPath {
        static var path: String { return baseURL }
        var urlString: String { return ProductCategory.path }
        
        static var all: String { return path / "api" / "productcategory" / "getall"}
    }
    
    struct Product: ApiPath {
        static var path: String { return baseURL }
        var urlString: String { return Product.path }
        
        var id: Int = 0
        init(id: Int) {
            self.id = id
        }
        
        var detail: String { return urlString / "api" / "product" / "getall" / id }
        static var all: String { return path / "api" / "product" / "getall"}
        var byCategory: String { return urlString / "api" / "product" / "getallbycategory" / id }
    }
    
    struct Post: ApiPath {
        static var path: String { return baseURL }
        var urlString: String { return Post.path }
        
        var id: Int = 0
        init(id: Int) {
            self.id = id
        }
        
        var detail: String { return urlString / "api" / "post" / "getall" / id }
        static var all: String { return path / "api" / "post" / "getall"}
    }
    struct Order: ApiPath {
        static var path: String { return baseURL }
        var urlString: String { return Order.path }
        
        static var order: String { return path / "api" / "order" / "add"}
    }
    struct FeedBack: ApiPath {
        static var path: String { return baseURL }
        var urlString: String { return Order.path }
        
        static var feedback: String { return path / "api" / "feedback" / "add"}
    }
}

    
protocol URLStringConvertible {
    var urlString: String { get }
}

protocol ApiPath: URLStringConvertible {
    static var path: String { get }
}

extension URL: URLStringConvertible {
    var urlString: String { return absoluteString }
}

extension Int: URLStringConvertible {
    var urlString: String { return String(describing: self) }
}

fileprivate func / (lhs: URLStringConvertible, rhs: URLStringConvertible) -> String {
    return lhs.urlString + "/" + rhs.urlString
}

extension String: URLStringConvertible {
    var urlString: String { return self }
}

extension CustomStringConvertible where Self: URLStringConvertible {
    var urlString: String { return description }
}
