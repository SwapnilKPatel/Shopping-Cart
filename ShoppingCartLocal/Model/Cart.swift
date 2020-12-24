//
//  Cart.swift
//  ShoppingCartLocal
//
//  Created by Swapnil Patel on 23/12/20.
//

import Foundation
import RealmSwift
class Cart {
    
    var items : [CartItem] = []
    /// Shared Object
    static var shared = Cart()
    
    /// Private initializer
    private init() {
       
    }
    
}

extension Cart {
    var total: Float {
        get { return items.reduce(0.0) { value, item in
            value + item.subTotal
            }
        }
    }
    
    var totalQuantity : Int {
        get { return items.reduce(0) { value, item in
            value + item.quantity
            }
        }
    }
    
    func updateCart(with product: Product) {
        if !self.contains(product: product) {
            self.add(product: product)
        } else {
            self.remove(product: product)
        }
        
        items.forEach{
            $0.save()
        }
        
    }
    
    func updateCart() {
        self.items.forEach{
            if $0.quantity == 0 {
                updateCart(with: $0.product)
            }
        }
    }
    
    func add(product: Product) {
        let item = items.filter { $0.product.ID == product.ID }
        
        if item.first != nil {
            item.first!.quantity += 1
            item.first!.save()
        } else {
            items.append(CartItem(product: product))
            items.forEach{
                $0.save()
            }
        }
        
        
    }
    
    func remove(product: Product) {
        guard let index = items.index(where: { $0.product.ID == product.ID }) else { return}
        items[index].delete()
        items.remove(at: index)
       
    }
    
    func contains(product: Product) -> Bool {
        let status = items.contains(where: { $0.product.ID == product.ID })
        return status
    }
}

