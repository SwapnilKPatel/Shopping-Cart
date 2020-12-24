//
//  Product.swift
//  ShoppingCartLocal
//
//  Created by Swapnil Patel on 23/12/20.
//

import Foundation
import RealmSwift
struct Product: Codable, Equatable {
    
    var ID: Int
    var name: String
    var price: Float
    var imageName: String
}

extension Product {
    // MARK: Equatable
    static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.ID == rhs.ID
    }
    
    func displayPrice() -> String {
        return String.init(format: "%.02f INR", price)
    }
}

class CartProduct: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var price: Float = 0.0
    @objc dynamic var quantity: Int = 0
    @objc dynamic var ID: Int = 0
    @objc dynamic var imageName: String = ""
    
    override class func primaryKey() -> String? {
        return "ID"
    }

}

