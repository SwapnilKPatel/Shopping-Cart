//
//  TableView+Extension.swift
//  ShoppingCartLocal
//
//  Created by Swapnil Patel on 23/12/20.
//

import UIKit

// MARK: - UITableView
extension UITableView {
    
    func registerCell(of cellClass: UITableViewCell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        
        if let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T {
            return cell
        } else {
            fatalError("Cell not exist with  Identifier " + T.reuseIdentifier)
        }
    
    }
    
}


