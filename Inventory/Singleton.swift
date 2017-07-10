//
//  Singleton.swift
//  Inventory
//
//  Created by Apple on 7/9/17.
//  Copyright © 2017 Salman. All rights reserved.
//

import Foundation
final class Singleton: NSObject {
    
    var responseData = [Response]()
    
    // MARK: - Shared Instance
    
    static let sharedInstance: Singleton = {
        let instance = Singleton()
        // setup code
        return instance
    }()
    
    // MARK: - Initialization Method
    
    override init() {
        super.init()
    }
    
    func archivedProducts(product: [Any])-> (Data) {
         let saveData = NSKeyedArchiver.archivedData(withRootObject: product)
         return saveData
    }
    
    func unArchivedProducts(data: NSData) -> [Response] {
        let details = NSKeyedUnarchiver.unarchiveObject(with: data as Data)
        return details as! [Response]
    }
}
