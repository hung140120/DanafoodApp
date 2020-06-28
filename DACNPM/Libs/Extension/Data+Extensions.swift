//
//  Data.swift
//  Car
//
//  Created by Dinh Hung on 1/16/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation

extension Data {
    func toJSON() -> Any? {
        do {
            return try JSONSerialization.jsonObject(
                with: self,
                options: JSONSerialization.ReadingOptions.allowFragments
            )
        } catch {
            return nil
        }
    }
    
    func toString() -> String? {
        return String(data: self, encoding: .utf8)
    }
}
