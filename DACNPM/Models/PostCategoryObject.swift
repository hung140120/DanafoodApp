//
//  postCategory.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/17/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import ObjectMapper

class PostCategoryObject: NSObject, Mappable {
    var ID: Int = 0
    var Name: String = ""
    var Alias: String = ""
    var Description: String = ""
    var Image: String = ""
    var HomeFlag: Bool = true
    var Posts: String = ""
    var CreatedBy: String = ""
    var CreatedDate: String = ""
    var UpdatedBy: String = ""
    var UpdatedDate: String = ""
    var Status: Bool = true
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init()
    }

    func mapping(map: Map) {
        ID              <-      map["ID"]
        Name            <-      map["Name"]
        Alias           <-      map["Alias"]
        Description     <-      map["Description"]
        Image           <-      map["Image"]
        HomeFlag        <-      map["HomeFlag"]
        Posts           <-      map["Posts"]
        CreatedBy       <-      map["CreatedBy"]
        CreatedDate     <-      map["CreatedDate"]
        UpdatedBy       <-      map["UpdatedBy"]
        UpdatedDate     <-      map["UpdatedDate"]
        Status          <-      map["Status"]
    }
}
