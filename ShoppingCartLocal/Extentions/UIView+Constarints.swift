//
//  UIView+Constarints.swift
//  ShoppingCartLocal
//
//  Created by Swapnil Patel on 23/12/20.
//

import UIKit

typealias ConstraintMetrics = [String : Any]

typealias YAxisAnchor = (anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat)
typealias XAxisAnchor = (anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat)

// MARK: - UIView
extension UIView {

    /// Reuse dentifier
    var reuseIdentifier: String { return String(describing: type(of: self)) }
    
    /// Reuse dentifier
    class var reuseIdentifier: String { return String(describing: self) }
    
}

extension UIView {
    
    /// Add subviews
    ///
    /// - Parameter views: Views to be added
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    /// Add Constraints with VFL
    @discardableResult
    func addConstraints(format: String, views: UIView..., options: NSLayoutConstraint.FormatOptions = [], metrics: [String : Any]? = nil) -> [NSLayoutConstraint] {
        
        var viewDictionary: [String : Any] = [:]
        
        for (index, view) in views.enumerated() {
            viewDictionary["v\(index)"] = view
        }
        
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: format, options: options, metrics: metrics, views: viewDictionary)
        addConstraints(constraints)
        
        return constraints
    }
    
}

extension UIView {
    
    /// Fill subviews
    ///
    /// - Parameters:
    ///   - views: subviews
    ///   - constant:
    func fill(views: UIView..., constant: CGFloat) {
        
        let metrics = [ "margin" : constant ]
        
        views.forEach( {
            addConstraints(format: "H:|-margin-[v0]-margin-|", views: $0, metrics: metrics)
            addConstraints(format: "V:|-margin-[v0]-margin-|", views: $0, metrics: metrics)
        })
        
    }
    
    func fillHorizontal(views: UIView..., constant: CGFloat) {
        
        let metrics = [ "margin" : constant ]
        
        views.forEach( {
            addConstraints(format: "H:|-margin-[v0]-margin-|", views: $0, metrics: metrics)
        })
        
    }
    
    func fillVertical(views: UIView..., constant: CGFloat) {
        
        let metrics = [ "margin" : constant ]
        
        views.forEach( {
            addConstraints(format: "V:|-margin-[v0]-margin-|", views: $0, metrics: metrics)
        })
        
    }
    
}

extension UIView {
    
    @discardableResult
    func attachTo(_ view: UIView, constant: CGFloat = 0) -> (horizontalContsaints: [NSLayoutConstraint], verticalContsaints: [NSLayoutConstraint]) {
        let horizontalContsaints = attachHorizontalTo(view, constant: constant)
        let verticalContsaints = attachVerticalTo(view, constant: constant)
        return (horizontalContsaints, verticalContsaints)
    }
    
    @discardableResult
    func attachTo(_ view: UIView, horizontal: CGFloat = 0, vertical: CGFloat = 0) -> (horizontalContsaints: [NSLayoutConstraint], verticalContsaints: [NSLayoutConstraint]) {
        let horizontalContsaints = attachHorizontalTo(view, constant: horizontal)
        let verticalContsaints = attachVerticalTo(view, constant: vertical)
        return (horizontalContsaints, verticalContsaints)
    }

    @discardableResult
    func attachHorizontalTo(_ view : UIView, constant: CGFloat = 0) -> [NSLayoutConstraint] {
        let metrics = ["margin" : constant]
        return view.addConstraints(format: "H:|-margin-[v0]-margin-|", views: self, metrics: metrics)
    }
    
    @discardableResult
    func attachVerticalTo(_ view: UIView, constant: CGFloat = 0) -> [NSLayoutConstraint] {
        let metrics = ["margin" : constant]
        return view.addConstraints(format: "V:|-margin-[v0]-margin-|", views: self, metrics: metrics)
    }
    
    @discardableResult
    func attachVerticalAnchorTo(_ view: UIView, constant: CGFloat = 0) -> (top: NSLayoutConstraint, bottom: NSLayoutConstraint)  {
        let topContraint = topAnchor.constraint(equalTo: view.topAnchor, constant: constant)
        let bottomContraint = bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: constant)
        NSLayoutConstraint.activate([topContraint, bottomContraint])
        return (topContraint, bottomContraint)
    }
    
    @discardableResult
    func attachHorizontalAnchorTo(_ view: UIView, constant: CGFloat = 0) -> (leading: NSLayoutConstraint, trailing: NSLayoutConstraint)  {
        let leadingContraint = leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant)
        let trailingContraint = trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constant)
        NSLayoutConstraint.activate([leadingContraint, trailingContraint])
        return (leadingContraint, trailingContraint)
    }
    
    @discardableResult
    func attachAnchorTo(_ view: UIView, constant: CGFloat = 0) -> (top: NSLayoutConstraint, leading: NSLayoutConstraint, trailing: NSLayoutConstraint, bottom: NSLayoutConstraint)  {
        let horizontalConstaints = attachHorizontalAnchorTo(view, constant: constant)
        let verticalConstaints = attachVerticalAnchorTo(view, constant: constant)
        return (verticalConstaints.top, horizontalConstaints.leading, horizontalConstaints.trailing, verticalConstaints.bottom)
    }
    
    @discardableResult
    func attachCenterTo(_ view: UIView, constant: CGFloat = 0) -> (horizontalCenter: NSLayoutConstraint, verticalCenter: NSLayoutConstraint) {
        let horizontalCenter = attachHorizontalCenterTo(view, constant: constant)
        let verticalCenter = attachVerticalCenterTo(view, constant: constant)
        return (horizontalCenter, verticalCenter)
    }
    
    @discardableResult
    func attachHorizontalCenterTo(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        let contraint = centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant)
        contraint.isActive = true
        return contraint
    }
    
    @discardableResult
    func attachVerticalCenterTo(_ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        let contraint = centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant)
        contraint.isActive = true
        return contraint
    }

    func attachAnchorsTo(_ view: UIView, top: CGFloat? = nil, leading: CGFloat? = nil, trailing: CGFloat? = nil, bottom: CGFloat? = nil) {
        
        if let constant = top {
            topAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
        }

        if let constant = leading {
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant).isActive = true
        }

        if let constant = trailing {
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant).isActive = true
        }

        if let constant = bottom {
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant).isActive = true
        }

    }
    
    func attachAnchors(_ view: UIView, top: CGFloat? = nil, leading: CGFloat? = nil, trailing: CGFloat? = nil, bottom: CGFloat? = nil) {
        
        if let constant = top {
            topAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
        }

        if let constant = leading {
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant).isActive = true
        }

        if let constant = trailing {
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant).isActive = true
        }

        if let constant = bottom {
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant).isActive = true
        }

    }
    
    func attachAnchors(top: YAxisAnchor? = nil, leading: XAxisAnchor? = nil, trailing: XAxisAnchor? = nil, bottom: YAxisAnchor? = nil) {
        
        if let (anchor, constant) = top {
            topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }

        if let (anchor, constant) = leading {
            leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }

        if let (anchor, constant) = trailing {
            trailingAnchor.constraint(equalTo: anchor, constant: -constant).isActive = true
        }

        if let (anchor, constant) = bottom {
            bottomAnchor.constraint(equalTo: anchor, constant: -constant).isActive = true
        }

    }

}

extension UIViewController {
    
    var topAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return view.safeAreaLayoutGuide.topAnchor
        } else {
            return topLayoutGuide.bottomAnchor
        }
    }
    
    var bottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return view.safeAreaLayoutGuide.bottomAnchor
        } else {
            return bottomLayoutGuide.topAnchor
        }
    }
    
    var leadingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return view.safeAreaLayoutGuide.leadingAnchor
        } else {
            return view.leadingAnchor
        }
    }
    
    var trailingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return view.safeAreaLayoutGuide.trailingAnchor
        } else {
            return view.trailingAnchor
        }
    }
    
    var windowTopEdgeInset: CGFloat {
        return view.windowInset.top
    }
    
    var windowBottomEdgeInset: CGFloat {
        return view.windowInset.bottom
    }
    
}


extension UIView {
    
    var windowInset: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            let keyWindow = Array(UIApplication.shared.connectedScenes)
                    .compactMap { $0 as? UIWindowScene }
                    .flatMap { $0.windows }
                    .first(where: { $0.isKeyWindow })
            
            return keyWindow?.safeAreaInsets ?? .zero
        } else {
            return .zero
        }
    }
    
    var windowTopEdgeInset: CGFloat {
        return windowInset.top
    }
    
    var windowBottomEdgeInset: CGFloat {
        return windowInset.bottom
    }
    
    var viewSafeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return safeAreaInsets
        } else {
            return .zero
        }
    }
    
    var topEdgeInset: CGFloat {
        return viewSafeAreaInsets.top
    }
    
    var bottomEdgeInset: CGFloat {
        return viewSafeAreaInsets.bottom
    }
    
}


extension NSLayoutConstraint {
    
    @discardableResult
    func activate(with priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        if let priority = priority {
            self.priority = priority
        }
        isActive = true
        return self
    }
    
    @discardableResult
    func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
    
}


