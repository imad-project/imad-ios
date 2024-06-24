//
//  RecommendLists.swift
//  IMAD_Project
//
//  Created by 유영웅 on 6/24/24.
//

import Foundation

struct RecommendTVResponse: Codable,Hashable {
    let id: Int
    let name: String
    let posterPath: String?
    let backdropPath:String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
