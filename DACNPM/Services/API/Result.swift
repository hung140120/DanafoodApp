//
//  Result.swift
//  XoSo
//
//  Created by Dinh Hung on 4/21/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import Alamofire

extension Result {
    func isSuccess(completion: ((Value) -> Void)?) -> Result<Value> {
        guard let value = self.value else {
            return self
        }
        completion?(value)
        return self
    }
    
    func `error`(completion: @escaping (Error) -> Void) {
        guard let error = self.error else {
            return
        }
        completion(error)
    }
}
