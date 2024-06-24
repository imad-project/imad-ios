//
//  TrendRecommend.swift
//  IMAD_Project
//
//  Created by 유영웅 on 6/24/24.
//

import Foundation

struct TrendRecommendResponse:Codable{
    var trendRecommendationTv: RecommendList?
    var trendRecommendationMovie: RecommendList?
    
    enum CodingKeys: String, CodingKey {
        case trendRecommendationTv = "trend_recommendation_tv"
        case trendRecommendationMovie = "trend_recommendation_movie"
    }
}
