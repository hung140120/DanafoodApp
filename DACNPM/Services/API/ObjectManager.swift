//
//  ObjectManager.swift
//  XoSo
//
//  Created by Dinh Hung on 4/16/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper

class ObjectManager: NSObject {
    var phoneNumber = BehaviorRelay<String>(value: "")
    var password = BehaviorRelay<String>(value: "")
    var moneyTotal = BehaviorRelay<Double>(value: 0.0)
    var user = BehaviorRelay<UserObject?>(value: UserObject())
    var listUser = BehaviorRelay<[UserObject]>(value: [])
    var productCategory = BehaviorRelay<[ProductCategoryObject]>(value: [])
    var product = BehaviorRelay<[ProductObject]>(value: [])
    var post = BehaviorRelay<[PostObject]>(value: [])
    var order = BehaviorRelay<OrderObject>(value: OrderObject())
    var orderDetails = BehaviorRelay<[OrderDetails]>(value: [])
    
    static let shared :  ObjectManager = {
        let instance =  ObjectManager()
        return instance
    }()
    
    func initData() {
        
    }
}
