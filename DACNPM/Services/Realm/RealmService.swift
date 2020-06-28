//
//  RealmService.swift
//  VideoBridges
//
//  Created by Nguyễn Phạm Thiên Bảo on 3/6/20.
//  Copyright © 2020 Nguyễn Phạm Thiên Bảo. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {
  public func safeWrite(_ block: (() throws -> Void)) throws {
    if isInWriteTransaction {
      try block()
    } else {
      try write(block)
    }
  }
}

struct RealmService {
  let realm = try! Realm()
  static var shared = RealmService()
  
  func add<T: Object>(_ object: T) {
    try! realm.safeWrite {
      realm.add(object)
    }
  }
  
  func update<T: Object>(_ object: T, keyValue: [String: Any]) {
    try! realm.safeWrite {
      keyValue.forEach({ key, value in
        object.setValue(value, forKey: key)
      })
    }
  }
  
  func remove<T: Object>(_ object: T) {
    try! realm.safeWrite {
      realm.delete(object)
    }
  }
  
  func getAll<T: Object>(for object: T.Type) -> [T] {
    //let realm = try! Realm()
    return Array(realm.objects(object))
  }
}
