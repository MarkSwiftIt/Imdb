//
//  SearchResponce.swift
//  18(Json)
//
//  Created by Mark Goncharov on 23.03.2022.
//

import Foundation

struct SearchRespone: Decodable {
    var searchType: String
    var expression: String
    var errorMessage: String
    var results: [Movies]

}

struct Movies: Decodable {
    var id: String
    var resultType: String
    var image: String
    var title: String
    var description: String
}

