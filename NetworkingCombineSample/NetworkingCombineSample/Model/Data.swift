//
//  Data.swift
//  NetworkingCombine
//
//  Created by Balraj Verma on 11/30/20.
//

import Foundation

struct JsonDat: Identifiable, Codable {
//    "userId": 1,
//        "id": 1,
//        "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
//        "body":
    
     var userId: Int
     var id: Int
     var title: String
     var body: String
    
    enum  codingkeys: String, CodingKey{
        case userId
        case id
        case title
        case body
    }
}
