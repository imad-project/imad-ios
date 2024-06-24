//
//  RecommendLists.swift
//  IMAD_Project
//
//  Created by 유영웅 on 6/24/24.
//

import Foundation

struct RecommendResponse: Codable {
    let id: Int
    let name: String
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
    }
}
