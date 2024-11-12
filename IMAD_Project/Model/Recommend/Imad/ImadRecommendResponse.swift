//
//  ImadRecommend.swift
//  IMAD_Project
//
//  Created by 유영웅 on 6/24/24.
//

import Foundation

struct ImadRecommendResponse:Codable{
    var popularRecommendationTv:NetworkWorkListResponse<RecommendResponse>?
    var popularRecommendationMovie:NetworkWorkListResponse<RecommendResponse>?
    var topRatedRecommendationTv:NetworkWorkListResponse<RecommendResponse>?
    var topRatedRecommendationMovie:NetworkWorkListResponse<RecommendResponse>?
    
    enum CodingKeys: String, CodingKey {
        case popularRecommendationTv = "popular_recommendation_tv"
        case popularRecommendationMovie = "popular_recommendation_movie"
        case topRatedRecommendationTv = "top_rated_recommendation_tv"
        case topRatedRecommendationMovie = "top_rated_recommendation_movie"
    }
}
