//
//  Data.swift
//  test1
//
//  Created by Офелия Баширова on 21.09.2020.
//  Copyright © 2020 Офелия Баширова. All rights reserved.
//

import Foundation

struct Response: Decodable {
    let data: [Datas]
    let meta: Meta
   
}
struct Datas: Decodable {
    let name: String
    let price: String
    let description: String
    let discount_amount: String
    let image: String
    let categories: [Categoriess]
}
struct Meta: Decodable {
    let pagination: Pagination
}
struct Pagination: Decodable {
    let total: Int
    let pages: Int
    let limit: Int
}
struct Categoriess: Decodable {
    let id: Int
    let name: String
}
