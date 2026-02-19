//
//  ProductViewModel.swift
//  15_10_2025_MVVM_Demo
//
//  Created by Vishal Jagtap on 18/02/26.
//



final class ProductViewModel{
    var products : [Product] = []
    var eventHandler : ((Event)->Void)?
    
    func fetchProducts(){
        APIManager.shared.getAllProducts { (result) in
            switch result{
            case .success(let newProductsArray):
                self.products.append(contentsOf: newProductsArray)
                self.eventHandler!(.dataLoaded)
                
            case .failure(let error):
                self.eventHandler!(.stopLoading)
            }
        }
    }
}

extension ProductViewModel{
    enum Event{
        case loading
        case dataLoaded
        case stopLoading
    }
}
