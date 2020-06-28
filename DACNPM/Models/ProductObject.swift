//
//  ProductObject.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/17/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class ProductObject: Object, Mappable {
    @objc dynamic var ProductCategory: String = ""
    @objc dynamic var ID: Int = 0
    @objc dynamic var Name: String = ""
    @objc dynamic var Alias: String = ""
    @objc dynamic var CategoryID: Int = 0
    @objc dynamic var Image: String = ""
    @objc dynamic var MoreImages: String = ""
    @objc dynamic var Price: Double = 0
    @objc dynamic var PromotionPrice: Double = 0
    @objc dynamic var Warranty: String = ""
    @objc dynamic var Description: String = ""
    @objc dynamic var Content: String = ""
    @objc dynamic var HomeFlag: Bool = true
    @objc dynamic var HotFlag: Bool = true
    @objc dynamic var Quantity: Int = 0
    @objc dynamic var Tags: Int = 0
    @objc dynamic var ProductTags: Int = 0
    @objc dynamic var CreatedBy: String = ""
    @objc dynamic var CreatedDate: String = ""
    @objc dynamic var UpdatedBy: String = ""
    @objc dynamic var UpdatedDate: String = ""
    @objc dynamic var Status: Bool = true
    
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        ProductCategory     <-      map["ProductCategory"]
        ID                  <-      map["ID"]
        Name                <-      map["Name"]
        Alias               <-      map["Alias"]
        CategoryID          <-      map["CategoryID"]
        Description         <-      map["Description"]
        Image               <-      map["Image"]
        MoreImages          <-      map["MoreImages"]
        Price               <-      map["Price"]
        PromotionPrice      <-      map["PromotionPrice"]
        Warranty            <-      map["Warranty"]
        Content             <-      map["Content"]
        HomeFlag            <-      map["HomeFlag"]
        HotFlag             <-      map["HotFlag"]
        Quantity            <-      map["Quantity"]
        Tags                <-      map["Tags"]
        ProductTags         <-      map["ProductTags"]
        CreatedBy           <-      map["CreatedBy"]
        CreatedDate         <-      map["CreatedDate"]
        UpdatedBy           <-      map["UpdatedBy"]
        UpdatedDate         <-      map["UpdatedDate"]
        Status              <-      map["Status"]
    }
}
