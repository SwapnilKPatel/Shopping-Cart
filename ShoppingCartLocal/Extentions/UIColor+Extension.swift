//
//  UIColor+Extension.swift
//  ShoppingCartLocal
//
//  Created by Swapnil Patel on 23/12/20.
//

import UIKit

extension UIColor {
    
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat = 1.0) {
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: opacity)
    }
    
    convenience init(red: Int, green: Int, blue: Int, opacity: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: opacity)
    }
    
    convenience init(rgb: Int, opacity: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            opacity: opacity
        )
    }
    
    static func hex(rgb: Int, opacity: CGFloat = 1.0) -> UIColor {
        return UIColor(rgb: rgb, opacity: opacity)
    }
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat = 1.0) -> UIColor {
        return UIColor(red: red, green: green, blue: blue, opacity: opacity)
    }
    
}


extension UIColor {
    
    // App colors
    static var primary = hex(rgb: 0x232323)
}
