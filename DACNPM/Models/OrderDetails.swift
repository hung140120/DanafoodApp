//
//  OrderDetails.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/27/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import ObjectMapper

class OrderDetails: NSObject, Mappable {
    var ProductID : Int = 0
    var Quantity: Int = 0
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init()
    }

    func mapping(map: Map) {
        ProductID       <-      map["ProductID"]
        Quantity        <-      map["Quantity"]
    }
}
