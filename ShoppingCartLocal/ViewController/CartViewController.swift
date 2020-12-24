//
//  CartViewController.swift
//  ShoppingCartLocal
//
//  Created by Swapnil Patel on 23/12/20.
//

import UIKit

class CartViewController: BaseController, LoadableController {
    
    private let tableView = customize(UITableView()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tableFooterView = UIView(frame: .zero)
        $0.bounces = false
        $0.estimatedRowHeight = 200
        $0.separatorStyle = .none
        $0.backgroundColor = .white
        $0.rowHeight = UITableView.automaticDimension
        $0.sectionHeaderHeight = UITableView.automaticDimension
        $0.registerCell(of: CartItemTableViewCell.self)
    }
   
    private let totalView = customize(UIView()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
        $0.heightAnchor.constraint(equalToConstant: 50).activate()
    }
    
    private let totalLabel = customize(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .boldSystemFont(ofSize: 14)
        $0.textColor = .white
        
    }
    
    private let cartStateLabel = customize(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 17)
        $0.text = "Please fill your cart by adding some products"
        $0.textColor = .black
        $0.textAlignment = .center
        
    }
    
    var quotes : [(key: String, value: Float)] = []
    let currencyHelper = CurrencyHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarStyle = .light
        configureBackButton()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        setupView()
        
        title = "Cart"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showActivityIndicator()
        hideActivityIndicator()
        
        let total = Cart.shared.total
        totalLabel.text = "Cart Total: ".appending(currencyHelper.display(total: total)) 
    }
    
    func setupView(){
        view.addSubviews(tableView, totalView, cartStateLabel)
        tableView.attachAnchors(top: (topAnchor,0), leading: (leadingAnchor,0), trailing: (trailingAnchor,0))
        totalView.attachAnchors(top: (tableView.bottomAnchor,0), leading: (leadingAnchor,0), trailing: (trailingAnchor,0), bottom:(bottomAnchor,0))
        cartStateLabel.attachAnchors(top: (topAnchor,10), leading: (leadingAnchor,0), trailing: (trailingAnchor,0))

        totalView.addSubview(totalLabel)
        totalView.fill(views: totalLabel, constant: 10)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showActivityIndicator() {
        //Hide the view components
        tableView.alpha = 0
        totalView.alpha = 0
        cartStateLabel.alpha = 0
    }
    
    func hideActivityIndicator() {
        //Animate the cart view display
        UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 3, options: .curveEaseInOut, animations: {
            
            //show the view components
            self.tableView.alpha = 1
            self.totalView.alpha = 1
            self.cartStateLabel.alpha = Cart.shared.items.count == 0 ? 1 : 0

        }, completion: nil)
    }
    
}
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (Cart.shared.items.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CartItemTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        let cartItem = Cart.shared.items[indexPath.item]
        cell.delegate = self as CartItemDelegate
        cell.viewModel = cartItem
      //  cell.stapperDidTap = { [unowned self] cell in
            
//            guard let indexPath1 = self.tableView.indexPath(for: cell) as 
//                else {
//                    return
//            }
//            if (sender as! UIButton).tag == 0 {
//                quantity = quantity + 1
//            } else if quantity > 0 {
//                quantity = quantity - 1
//            }
//
            //  decrementButton.isEnabled = quantity > 0
            //decrementButton.backgroundColor = !decrementButton.isEnabled ? .gray : .black
            
            //cell.delegate?.updateCartItem(cell: cell, quantity: cell.stapp)
    //    }
        return cell
    }
}

extension CartViewController: CartItemDelegate {
    
    // MARK: - CartItemDelegate
    func updateCartItem(cell: CartItemTableViewCell, quantity: Int) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let cartItem = Cart.shared.items[indexPath.row]
        
        //Update cart item quantity
        cartItem.quantity = quantity
        
        //Update displayed cart total
        let total = Cart.shared.total
      //  cart?.save()
        //totalLabel.text = currencyHelper.display(total: total)
        totalLabel.text = "Cart Total: ".appending(currencyHelper.display(total: total))
        
        Cart.shared.items.forEach{
            $0.save()
        }
    }
    
}

