//
//  UserObject.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/8/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class UserObject: NSObject, Mappable {
    var Fullname: String = ""
    var PhoneNumber: String = ""
    var Password: String = ""
    var token_type: String = ""
    var access_token: String = ""
    var Username: String = ""
    var Email: String = ""
    var Birthday: String = ""
    var Address: String = ""
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init()
    }
    
    func mapping(map: Map) {
        Fullname        <-      map["FullName"]
        PhoneNumber     <-      map["PhoneNumber"]
        token_type      <-      map["token_type"]
        access_token    <-      map["access_token"]
        Username        <-      map["Username"]
        Email           <-      map["Email"]
        Birthday        <-      map["BirthDay"]
        Address         <-      map["Address"]
    }
}
