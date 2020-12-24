//
//  CartItem.swift
//  ShoppingCartLocal
//
//  Created by Swapnil Patel on 23/12/20.
//

import Foundation
import RealmSwift
class CartItem {
    
    var quantity : Int = 1
    var product : Product
    
    var subTotal : Float { get { return product.price * Float(quantity) } }
    
    init(quantity: Int = 1, product: Product) {
        self.quantity = quantity
        self.product = product
    }
}
extension CartItem{
    
    func save() {
        do {
            let realm = try Realm()
            let object = CartProduct()
            object.ID = product.ID
            object.name = product.name
            object.price = product.price
            object.quantity = quantity
            try realm.write { realm.add(object, update: .all) }
        } catch {
            debugPrint("Realm Save Error: \(error)")
        }
        
    }
    
    func delete() {
        
        do {
            let realm = try Realm()
            guard let object = realm.objects(CartProduct.self).filter("ID == %d", product.ID).first else { return }
            try realm.write { realm.delete(object) }
        } catch {
            debugPrint("Realm Delete Error: \(error)")
        }
        
    }
}

