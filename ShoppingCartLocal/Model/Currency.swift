//
//  Currency.swift
//  ShoppingCartLocal
//
//  Created by Swapnil Patel on 23/12/20.
//

import Foundation

struct Currency: Codable {
    var quotes : Dictionary<String,Float>
    var timestamp : Int64
}
