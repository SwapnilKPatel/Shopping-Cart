//
//  NavigationController.swift
//  ForecastIOS
//
//  Created by Swapnil Patel on 31/10/20.
//

import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension NavigationController {
    
    override var prefersStatusBarHidden: Bool {
        return visibleViewController?.prefersStatusBarHidden ?? false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return visibleViewController?.preferredStatusBarStyle ?? .lightContent
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return visibleViewController?.supportedInterfaceOrientations ?? .all
    }
    
    override var shouldAutorotate: Bool {
        return visibleViewController?.shouldAutorotate ?? false
    }
    
}

