//
//  ViewController.swift
//  15_10_2025_MVVM_Demo
//
//  Created by Vishal Jagtap on 16/02/26.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var productsTableView: UITableView!
    let productViewModel = ProductViewModel()
    let reuseIdentifierProductTableViewCell = "ProductTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerXIBWithTableView()
        initViewModel()
        observeEvent()
    }
    
    func registerXIBWithTableView(){
        productsTableView.delegate = self
        productsTableView.dataSource = self
        
        let uiNib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        self.productsTableView.register(uiNib, forCellReuseIdentifier: reuseIdentifierProductTableViewCell)
    }
    
    
    func initViewModel(){
        productViewModel.fetchProducts()
    }
    
    func observeEvent(){
        productViewModel.eventHandler = { [weak self] event in
            switch event{
                case .loading:
                    print("Products Data Loading is in process!")
                case .dataLoaded:
                    print("Products Data Completely Loaded!")
                    DispatchQueue.main.async {
                        self?.productsTableView.reloadData()
                    }
                case .stopLoading:
                    print("Products Data Stopped loading...")
            }
        }
    }
}

extension ViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132.0
    }
}

extension ViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.productViewModel.products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productTableViewCell = self.productsTableView.dequeueReusableCell(withIdentifier: reuseIdentifierProductTableViewCell, for: indexPath) as! ProductTableViewCell
        
        productTableViewCell.productTitleLabel.text = self.productViewModel.products[indexPath.row].title
        productTableViewCell.productDescriptionLabel.text = self.productViewModel.products[indexPath.row].description
        productTableViewCell.productPriceLabel.text = "\(self.productViewModel.products[indexPath.row].price)"
        
        let urlOfImage = URL(string: self.productViewModel.products[indexPath.row].image)
        productTableViewCell.productImageView.kf.setImage(with: urlOfImage,placeholder: UIImage(named: "test_image_2"))
        
        return productTableViewCell
    }
}
