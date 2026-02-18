//
//  APIManager.swift
//  15_10_2025_MVVM_Demo
//
//  Created by Vishal Jagtap on 16/02/26.
//

import Foundation

enum DataError : Error{
    case invalidUrl
    case invalidData
    case invalidDecoder
    case networkError(Error)
}

typealias ProductCompletionHandler = ((Result<[Product],DataError>)->Void)

final class APIManager{
    
    static let shared = APIManager()
    
    private init(){}
    
    func getAllProducts(completionHandler : @escaping ProductCompletionHandler){
        guard let url = URL(string: Constants.productsUrlString) else {
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            let jsonDecoder = JSONDecoder()
            
            do{
                let products = try jsonDecoder.decode([Product].self, from: data!)
                completionHandler(.success(products))
            }catch{
                print(error)
                completionHandler(.failure(error as! DataError))
            }
        }
        
        dataTask.resume()
    }
}
