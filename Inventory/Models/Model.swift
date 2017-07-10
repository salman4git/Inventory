//
//  Model.swift
//  
//
//  Created by Apple on 17/03/17.
//  Copyright © 2017 Salman. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class Response: NSObject, NSCoding, Mappable {

     var product_id: String?
     var brand: String?
     var details: String?
     var image_url: String?
     var price: Int?
     var originalPrice: Int?
     var title: String?
    
    override init() {}
    
    required init?(map: Map) {
        super.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
         product_id <- map["_id"]
         brand <- map["brand"]
         details <- map["description"]
         image_url <- map["images.0.imageUrl"]
         price <- map["price"]
         originalPrice <- map["originalPrice"]
         title <- map["title"]
    }
    
    required init(coder decoder: NSCoder) {
        super.init()
        self.product_id = decoder.decodeObject(forKey: "product_id") as? String ?? ""
        self.brand = decoder.decodeObject(forKey: "brand") as? String
        self.details = decoder.decodeObject(forKey: "description") as? String
        self.image_url = decoder.decodeObject(forKey: "image_url") as? String
        self.price = decoder.decodeObject(forKey: "price") as? Int
        self.originalPrice = decoder.decodeObject(forKey: "originalPrice") as? Int
        self.title = decoder.decodeObject(forKey: "title") as? String
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(product_id, forKey: "product_id")
        coder.encode(brand, forKey: "brand")
        coder.encode(details, forKey: "description")
        coder.encode(image_url, forKey: "image_url")
        coder.encode(price, forKey: "price")
        coder.encode(originalPrice, forKey: "originalPrice")
        coder.encode(title, forKey: "title")
    }
    
}

 

