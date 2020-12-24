//
//  Navigator.swift
//  ForecastIOS
//
//  Created by Swapnil Patel on 31/10/20.
//

import UIKit

protocol LoadableController {
    static func getController() -> Self
}

extension LoadableController where Self : UIViewController {
    
    static func getController() -> Self {
        return Self()
    }
    
}

struct Navigator {
    
    /// Private initializer
    private init() { }
    
}

extension Navigator {
    
    /// Root view controller
    ///
    /// - Parameters:
    ///   - isLaunching: Is app launching or not
    ///   - launchOptions: Lanch Options
    /// - Returns: Root view controller
    static func rootViewController(isLaunching: Bool = false, launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> UIViewController {
            
        
            // Open Map screen
        /// Navigation Controller
        let navigationController = customize(NavigationController()) {
            $0.viewControllers = [ProductsTableViewController.getController()]
        }
            return navigationController
        }
        
    /// Open roor view controller
    ///
    /// - Parameters:
    ///   - isLaunching: Is app launching or not
    ///   - launchOptions: Lanch Options
    /// - Returns: Root view controller
    static func openRootViewController(isLaunching: Bool = false, launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) {
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let rootViewController = self.rootViewController(isLaunching: isLaunching, launchOptions: launchOptions)
            appDelegate.window?.rootViewController = rootViewController
        }
    }

}
