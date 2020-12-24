//
//  ProductsListHelper.swift
//  ShoppingCartLocal
//
//  Created by Swapnil Patel on 23/12/20.
//

import Foundation

class ProductsListHelper {
    
    private let productsJson = """
        [
            {
                "ID": 1,
                "name": "Watch",
                "price": 7000,
                 "imageName": "ProductWatch"
            },
            {
                "ID": 2,
                "name": "Phone",
                "price": 50000,
                 "imageName": "ProductPhone",
            },
            {
                "ID": 3,
                "name": "Wallet",
                "price": 200,
                 "imageName": "ProductWallet",
            },
            {
                "ID": 4,
                "name": "HeadPhone",
                "price": 4000,
                "imageName": "ProductHeadPhone",
            }
        ]
        """.data(using: .utf8)!
    
    func all() -> [Product] {
        let decoder = JSONDecoder()
        let products = try! decoder.decode([Product].self, from: productsJson)
        
        return products
    }
}

