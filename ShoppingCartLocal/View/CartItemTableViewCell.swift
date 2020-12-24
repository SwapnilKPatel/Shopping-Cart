//
//  CartItemTableViewCell.swift
//  ShoppingCartLocal
//
//  Created by Swapnil Patel on 23/12/20.
//

import UIKit

protocol CartItemDelegate {
    func updateCartItem(cell: CartItemTableViewCell, quantity: Int)
}

class CartItemTableViewCell: UITableViewCell {
    
    var viewModel: CartItem? {
        didSet {
            if let data = viewModel {
                nameLabel.text = ("\(data.product.name) \n\(data.product.displayPrice())")
                priceLabel.text = data.product.displayPrice()
                quantityLabel.text = String(describing: data.quantity)
                quantity = data.quantity
            }
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    let nameLabel = customize(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    
    let priceLabel = customize(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.textColor = .black
    }
    
    let quantityLabel = customize(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.textAlignment = .center
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.widthAnchor.constraint(equalToConstant: 50).activate()
        $0.textColor = .black
    }
    
    let incrementButton = customize(UIButton()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
        $0.titleLabel?.textColor = .white
        $0.setTitle("+", for: .normal)
        $0.tag = 0
        $0.widthAnchor.constraint(equalToConstant: 30).activate()
        $0.heightAnchor.constraint(equalToConstant: 30).activate()
    }
    
    let decrementButton = customize(UIButton()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
        $0.titleLabel?.textColor = .white
        $0.setTitle("-", for: .normal)
        $0.tag = 1
        $0.widthAnchor.constraint(equalToConstant: 30).activate()
        $0.heightAnchor.constraint(equalToConstant: 30).activate()
    }
    
    /// Conatainer view
    let container = customize(UIView()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
    }
    
    var delegate: CartItemDelegate?
    var quantity: Int = 1
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        super.awakeFromNib()
        
        // Initialization code
        incrementButton.layer.cornerRadius = 10
        incrementButton.clipsToBounds = true
        
        decrementButton.layer.cornerRadius = 10
        decrementButton.clipsToBounds = true
        setupView()
        
        incrementButton.addTarget(self, action: #selector(updateCartItemQuantity), for: .touchUpInside)
        decrementButton.addTarget(self, action: #selector(updateCartItemQuantity), for: .touchUpInside)
    }
    
    func setupView() {
        
        contentView.addSubviews(container)
        contentView.fill(views: container, constant: 0)
        contentView.addSubviews(container)
        
        let stackview = customize(UIStackView(arrangedSubviews:[decrementButton ,quantityLabel, incrementButton])) {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.axis = .horizontal
        }
        
        container.addSubviews(nameLabel, stackview)
        
        container.fillVertical(views: nameLabel, constant: 10)
        
        container.addConstraints(format: "V:|-10-[v0]", views: stackview)
        container.addConstraints(format: "H:|-20-[v0]-(>=10)-[v1]-20-|", views: nameLabel, stackview)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func updateCartItemQuantity(_ sender: Any) {
        if (sender as! UIButton).tag == 0 {
            quantity = quantity + 1
        } else if quantity > 0 {
            quantity = quantity - 1
        }
        decrementButton.isEnabled = quantity > 0
        decrementButton.backgroundColor = !decrementButton.isEnabled ? .gray : .black
        quantityLabel.text = String(describing: quantity)
        self.delegate?.updateCartItem(cell: self, quantity: quantity)
    }
}

