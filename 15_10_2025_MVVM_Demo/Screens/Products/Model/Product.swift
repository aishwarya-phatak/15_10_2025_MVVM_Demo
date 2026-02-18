//
//  Product.swift
//  15_10_2025_MVVM_Demo
//
//  Created by Vishal Jagtap on 16/02/26.
//

struct Product : Decodable{
    var id : Int
    var title : String
    var price : Double
    var description : String
    var category : String
    var image : String
    var rating : Rating
}

struct Rating : Decodable{
    var rate : Double
    var count : Int
}
