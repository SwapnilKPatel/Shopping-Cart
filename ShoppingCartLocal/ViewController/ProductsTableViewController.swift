//
//  ProductsTableViewController.swift
//  ShoppingCartLocal
//
//  Created by Swapnil Patel on 23/12/20.
//

import UIKit
import RealmSwift

class ProductsTableViewController: BaseController, LoadableController, UITableViewDelegate, UITableViewDataSource{
    
    /// Devices Table view
    private let tableView = customize(UITableView()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tableFooterView = UIView(frame: .zero)
        $0.bounces = false
        $0.estimatedRowHeight = 200
        $0.separatorStyle = .none
        $0.backgroundColor = .white
        $0.rowHeight = UITableView.automaticDimension
        $0.sectionHeaderHeight = UITableView.automaticDimension
        $0.registerCell(of: ProductTableViewCell.self)
    }
    
    fileprivate let products:[Product] = ProductsListHelper().all()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let  data = List<CartProduct>()
        if let realm = try? Realm() {
            debugPrint("Real Error!")
            let results = realm.objects(CartProduct.self)
            data.append(objectsIn: results)
            data.forEach {
                let item = CartItem(quantity: $0.quantity, product:Product(ID: $0.ID, name: $0.name, price: $0.price, imageName: $0.imageName))
                Cart.shared.items.append(item)
            }
        }
        navigationBarStyle = .light
        tableView.tableFooterView = UIView(frame: .zero)
        setupView()
        
        title = "Products"
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Workaround to avoid the fadout the right bar button item
        
        //Update cart if some items quantity is equal to 0 and reload the product table and right button bar item
        Cart.shared.updateCart()
        
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let checkOut = UIBarButtonItem(title:  "Checkout (\(Cart.shared.items.count))", style: .plain, target: self, action: #selector(checkOutTapped))
        navigationItem.rightBarButtonItems = [checkOut]
    }
    
    @objc func checkOutTapped() {
        self.navigationController?.pushViewController(CartViewController.getController(), animated: true)
    }
    
    func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        view.fill(views: tableView, constant: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ProductTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let product = products[indexPath.item]
        cell.delegate = self
        cell.viewModel = product
        cell.setButton(state: Cart.shared.contains(product: product))
        
        return cell
    }
}

extension ProductsTableViewController: CartDelegate {
    
    // MARK: - CartDelegate
    func updateCart(cell: ProductTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let product = products[indexPath.row]
        
        //Update Cart with product
        Cart.shared.updateCart(with: product)
        
        self.navigationItem.rightBarButtonItem?.title = "Checkout (\(Cart.shared.items.count))"
    }
    
}

