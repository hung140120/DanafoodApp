//
//  ConfirmViewModel.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/27/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper

class ConfirmViewModel: MVVMViewModel {
   
    var listProducts = [ProductObject]()
    var order = ObjectManager.shared.order
    var orderDetails = ObjectManager.shared.orderDetails
    
    init() {
        listProducts = RealmService.shared.getAll(for: ProductObject.self)
    }
    
    func order(orderDetails : [[String: Any]], moneyTotal : Double) {
        let order = ["CustomerName" : UDKey<Any>.User.username.value, "CustomerAddress": UDKey.User.address.value, "CustomerEmail": UDKey.User.email.value, "CustomerMobile": UDKey.User.phonenumber.value, "TotalMoney": moneyTotal]
        apiOrder(order: order as [String : Any], orderDetails: orderDetails ) { (result) in
            print(result.toJSON())
            self.orderDetails.accept(result)
        }
    }
}

extension ConfirmViewModel {
    fileprivate func apiOrder(order: [String:Any] ,orderDetails : [[String:Any]], completion: @escaping ([OrderDetails]) -> Void) {
        let param = Api.Order.OrderParam(dataOrder: order, dataOrderDetails: orderDetails)
        Api.Order.order(param: param) { (result) in
            result.isSuccess(completion: { (json) in
                guard let jsonData = json as? JSObject else { return }
                guard  let jsonDetails = jsonData["OrderDetails"] as? JSArray else { return }
                guard  let jsonOrder = jsonData["Order"] as? JSObject else { return }
                
                let object = Mapper<OrderObject>().map(JSON: jsonOrder)
                
                guard let results = jsonDetails.map({OrderDetails(JSON: $0)}) as? [OrderDetails] else {return}
                self.order.accept(object!)
                completion(results)
            }).error(completion: { error in
                print(error)
            })
        }
    }
}
