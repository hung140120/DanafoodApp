//
//  Dictionary.swift
//  Car
//
//  Created by Dinh Hung on 1/16/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation

extension Dictionary {
    mutating func updateValues(_ info: [Key: Value]?) {
        guard let info = info else { return }
        for (key, value) in info {
            self[key] = value
        }
    }
}
