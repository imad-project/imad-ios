//
//  GenreRecommend.swift
//  IMAD_Project
//
//  Created by 유영웅 on 6/24/24.
//

import Foundation

struct GenreRecommendResponse:Codable{
    var preferredGenreRecommendationTv: RecommendList?
    var preferredGenreRecommendationMovie: RecommendList?
    
    enum CodingKeys: String, CodingKey {
        case preferredGenreRecommendationTv = "preferred_genre_recommendation_tv"
        case preferredGenreRecommendationMovie = "preferred_genre_recommendation_movie"
    }
}
