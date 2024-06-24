//
//  WorkResults.swift
//  IMAD_Project
//
//  Created by 유영웅 on 6/24/24.
//

import Foundation

struct RecommendList: Codable,Hashable {
    let page, totalPages, totalResults: Int
    let results: [RecommendResponse]
    let contentsID: Int?

    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case results
        case contentsID = "contents_id"
    }
}



