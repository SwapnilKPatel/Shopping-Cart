//
//  BaseController.swift
//  ForecastIOS
//
//  Created by Swapnil Patel on 31/10/20.
//

import UIKit

class BaseController: UIViewController {
    
    /// Navigation Bar type
    var navigationBarStyle: NavigationBarStyle = .light {
        didSet {
            configureNavigatioBar()
        }
    }
    
    /// Mapview
    let activityIndicator = customize(UIActivityIndicatorView(style: .medium)) {
        $0.hidesWhenStopped = true
        $0.color = .white
    }
    
}

extension BaseController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureActivityIndicator()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigatioBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        navigationController != nil ? navigationBarStyle.statusBarStyle : .lightContent
    }
    
    override var shouldAutorotate: Bool { false }
    
    override var prefersStatusBarHidden: Bool { false }
    
}

extension BaseController {
    
    /// Configure navigation bar
    private func configureNavigatioBar() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        
        navigationBar.barTintColor = navigationBarStyle.backgroundColor
        navigationBar.backgroundColor = navigationBarStyle.backgroundColor
        navigationBar.isTranslucent = true
        navigationBar.tintColor = navigationBarStyle.primaryColor
        navigationBar.titleTextAttributes = [
            .foregroundColor : navigationBarStyle.primaryColor,
            .font : UIFont.systemFont(ofSize: 18)]
        
        navigationBar.setBackgroundImage(nil, for: .default)
        navigationBar.shadowImage = UIImage()
        
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNeedsStatusBarAppearanceUpdate()
    }
    
    // Configure Activity Indicator
    func configureActivityIndicator() {
        
        activityIndicator.tintColor = .white
        let refreshBarButton: UIBarButtonItem = UIBarButtonItem(customView: activityIndicator)
        self.navigationItem.rightBarButtonItem = refreshBarButton
        
    }
    
    // Configure Sidemenu
    func configureSideMenu() {
        
        let menuButton = UIBarButtonItem(image: UIImage(named: "iconMenu"), style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = menuButton
        
    }
    
    func indicatorStartAnimating () {
        activityIndicator.startAnimating()
    }
    
    func indicatorStopAnimating () {
        activityIndicator.stopAnimating()
    }
    
}

extension BaseController {
    
    enum NavigationBarStyle {
        case light
        
        var primaryColor: UIColor {
            switch self {
            case .light:
                return .white
            }
        }
        
        var backgroundColor: UIColor {
            switch self {
            case .light:
                return .black
            }
        }
        
        var statusBarStyle: UIStatusBarStyle {
            switch self {
            case .light:
                return .default
            }
        }
        
    }
    
}

// MARK:- UIViewController implementation
extension UIViewController {
    
    /// Pop or dismiss controller
    func popOrDismissController() {
        
        guard let navigationController = self.navigationController else {
            dismiss(animated: true, completion: nil)
            return
        }
        
        if navigationController.viewControllers.first == self {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController.popViewController(animated: true)
        }
        
    }
    
    /// Open controller in navigation controller
    ///
    /// - Parameter controller: Controller
    func openInNavigationController(_ controller: BaseController) {
        let navigationController = NavigationController(rootViewController: controller)
        navigationController.modalPresentationStyle = .overFullScreen
        present(navigationController, animated: true, completion: nil)
    }
    
    /// Configure Dismiss Button
    ///
    /// - Parameter backAction: Apply Back Behavi
    /// or
    func configureDismissButton(backAction: Bool = false) {
        
        let dismissButton = UIBarButtonItem(image: UIImage(named: "IconBackArrow"), style: .plain, target: nil, action: nil)
        
        dismissButton.actionClosure = {
            if backAction {
                self.navigationController?.popViewController(animated: true)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
        navigationItem.leftBarButtonItem = dismissButton
        
        
    }
    
    func buttonClicked(backAction: Bool = false){
       
    }
    
    /// Configure Back Button
    func configureBackButton() {
        configureDismissButton(backAction: true)
    }
    
}

extension UIBarButtonItem {
    private struct AssociatedObject {
        static var key = "action_closure_key"
    }

    var actionClosure: (()->Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedObject.key) as? ()->Void
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObject.key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            target = self
            action = #selector(didTapButton(sender:))
        }
    }

    @objc func didTapButton(sender: Any) {
        actionClosure?()
    }
}
