//
//  OrderObject.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/27/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import ObjectMapper

class OrderObject: NSObject, Mappable {
    var CustomerName : String = ""
    var CustomerAddress: String = ""
    var CustomerEmail: String = ""
    var CustomerMobile: String = ""
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init()
    }

    func mapping(map: Map) {
        CustomerName    <-      map["CustomerName"]
        CustomerAddress <-      map["CustomerAddress"]
        CustomerEmail   <-      map["CustomerEmail"]
        CustomerMobile  <-      map["CustomerMobile"]
        
    }
}

