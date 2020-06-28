//
//  PostObject.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/17/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import ObjectMapper

class PostObject: NSObject, Mappable {
    var PostCategory : String = ""
    var ID: Int = 0
    var Name: String = ""
    var Alias: String = ""
    var CategoryID: Int = 0
    var Description: String = ""
    var Content: String = ""
    var Image: String = ""
    var HomeFlag: Bool = true
    var HotFlag: Bool = true
    var PostTags: Int = 0
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
        PostCategory    <-      map["PostCategory"]
        ID              <-      map["ID"]
        Name            <-      map["Name"]
        Alias           <-      map["Alias"]
        CategoryID      <-      map["CategoryID"]
        Description     <-      map["Description"]
        Content         <-      map["Content"]
        Image           <-      map["Image"]
        HomeFlag        <-      map["HomeFlag"]
        HotFlag         <-      map["HotFlag"]
        PostTags        <-      map["PostTags"]
        CreatedBy       <-      map["CreatedBy"]
        CreatedDate     <-      map["CreatedDate"]
        UpdatedBy       <-      map["UpdatedBy"]
        UpdatedDate     <-      map["UpdatedDate"]
        Status          <-      map["Status"]
    }
}
