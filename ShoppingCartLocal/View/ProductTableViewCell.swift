//
//  ProductTableViewCell.swift
//  ShoppingCartLocal
//
//  Created by Swapnil Patel on 23/12/20.
//

import UIKit

protocol CartDelegate {
    func updateCart(cell: ProductTableViewCell)
}

class ProductTableViewCell: UITableViewCell {
    
    var viewModel: Product? {
        didSet {
            if let data = viewModel {
                nameLabel.text = data.name
                priceLabel.text = data.displayPrice()
                productImage.image = UIImage(named: data.imageName)
            }
            setNeedsLayout()
            layoutIfNeeded()
        }
    }

    let nameLabel = customize(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.textColor = .black
    }
    
    let productImage = customize(UIImageView()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
    }
    
    let priceLabel = customize(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.textColor = .black
    }
   
    let addToCartButton = customize(UIButton()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.titleLabel?.textColor = .black
        $0.titleLabel?.font = .systemFont(ofSize: 15)
        $0.widthAnchor.constraint(equalToConstant: 100).activate()
    }
    
    /// Conatainer view
    let container = customize(UIView()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
    }
    
    var delegate: CartDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        super.awakeFromNib()
        
        // Initialization code
        addToCartButton.layer.cornerRadius = 5
        addToCartButton.clipsToBounds = true
        addToCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        
        selectionStyle = .none
        contentView.addSubview(container)
        contentView.fill(views: container, constant: 0)
        
        container.addSubviews(productImage, nameLabel, priceLabel, addToCartButton)
        
        let metrics: [String: Any]  =
            [
                "space" : 10,
                "avtarWidth" : 50
            ]
        
        productImage.layer.cornerRadius = 3
        
        container.addConstraints(format: "H:|-space-[v0(avtarWidth)]-space-[v1]-space-|", views: productImage, nameLabel, metrics: metrics)
        
        nameLabel.attachAnchors(top: (container.topAnchor,10), bottom: (priceLabel.topAnchor,5))
        
        priceLabel.attachAnchors(top: (nameLabel.bottomAnchor,5), leading: (nameLabel.leadingAnchor,0), trailing: (nameLabel.trailingAnchor,5), bottom: (addToCartButton.topAnchor,5))
        
        addToCartButton.attachAnchors(top: (priceLabel.bottomAnchor,5), leading: (priceLabel.leadingAnchor,0), bottom: (container.bottomAnchor,10))
        
        NSLayoutConstraint.activate([
            productImage.heightAnchor.constraint(equalTo: productImage.widthAnchor, multiplier: 1).withPriority(.defaultHigh),
            productImage.topAnchor.constraint(equalTo: container.topAnchor,constant: 12),
        ])
        
    }
    
    func setButton(state: Bool) {
        addToCartButton.isSelected = state
        addToCartButton.setTitle("Remove", for: .selected)
        addToCartButton.setTitle("Add To Cart", for: .normal)
        addToCartButton.backgroundColor = (!addToCartButton.isSelected) ? .black : .red
    }
    
    @objc func addToCart(_ sender: Any) {
        setButton(state: !addToCartButton.isSelected)
        self.delegate?.updateCart(cell: self)
    }
}

