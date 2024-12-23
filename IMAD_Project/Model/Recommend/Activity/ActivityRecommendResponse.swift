//
//  ActivityRecommend.swift
//  IMAD_Project
//
//  Created by 유영웅 on 6/24/24.
//

import Foundation

struct ActivityRecommendResponse:Codable{
    var userActivityRecommendationTv:NetworkWorkListResponse<RecommendResponse>?
    var userActivityRecommendationMovie:NetworkWorkListResponse<RecommendResponse>?
    var userActivityRecommendationTvAnimation:NetworkWorkListResponse<RecommendResponse>?
    var userActivityRecommendationMovieAnimation:NetworkWorkListResponse<RecommendResponse>?
    
    enum CodingKeys: String, CodingKey {
        case userActivityRecommendationTv = "user_activity_recommendation_tv"
        case userActivityRecommendationMovie = "user_activity_recommendation_movie"
        case userActivityRecommendationTvAnimation = "user_activity_recommendation_tv_animation"
        case userActivityRecommendationMovieAnimation = "user_activity_recommendation_movie_animation"
    }
}
