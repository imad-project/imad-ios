//
//  TrendRecommend.swift
//  IMAD_Project
//
//  Created by 유영웅 on 6/24/24.
//

import Foundation

struct TrendRecommendResponse:Codable{
    var trendRecommendationTv: NetworkWorkListResponse<RecommendResponse>?
    var trendRecommendationMovie: NetworkWorkListResponse<RecommendResponse>?
    
    enum CodingKeys: String, CodingKey {
        case trendRecommendationTv = "trend_recommendation_tv"
        case trendRecommendationMovie = "trend_recommendation_movie"
    }
}
