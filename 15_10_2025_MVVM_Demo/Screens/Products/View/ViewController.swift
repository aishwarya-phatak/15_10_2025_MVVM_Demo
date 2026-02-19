//
//  ViewController.swift
//  15_10_2025_MVVM_Demo
//
//  Created by Vishal Jagtap on 16/02/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var productsTableView: UITableView!
    let productViewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        observeEvent()
    }
    
    func registerXIBWithTableView(){
        
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
                        <#code#>
                    }
                case .stopLoading:
                    print("Products Data Stopped loading...")
            }
        }
    }
}


extension ViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        <#code#>
    }
}


extension ViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.productViewModel.products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
