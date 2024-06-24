//
//  RecommendMovieResponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 6/24/24.
//

import Foundation

struct RecommendMovieResponse: Codable,Hashable {
    let id: Int
    let title: String
    let posterPath: String?
    let backdropPath:String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
