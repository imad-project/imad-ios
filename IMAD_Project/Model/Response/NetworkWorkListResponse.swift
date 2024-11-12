//
//  NetworkWorkListResponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 11/8/24.
//

import Foundation

struct NetworkWorkListResponse<T:Codable>:Codable{
    let page, totalPages, totalResults: Int
    let results: [T]
    let contentsID: Int?

    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case results
        case contentsID = "contents_id"
    }
}
