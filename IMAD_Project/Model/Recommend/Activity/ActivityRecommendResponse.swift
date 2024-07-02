//
//  ActivityRecommend.swift
//  IMAD_Project
//
//  Created by 유영웅 on 6/24/24.
//

import Foundation

struct ActivityRecommendResponse:Codable{
    var userActivityRecommendationTv:RecommendTVList?
    var userActivityRecommendationMovie:RecommendMovieList?
    var userActivityRecommendationTvAnimation:RecommendTVList?
    var userActivityRecommendationMovieAnimation : RecommendMovieList?
    
    enum CodingKeys: String, CodingKey {
        case userActivityRecommendationTv = "user_activity_recommendation_tv"
        case userActivityRecommendationMovie = "user_activity_recommendation_movie"
        case userActivityRecommendationTvAnimation = "user_activity_recommendation_tv_animation"
        case userActivityRecommendationMovieAnimation = "user_activity_recommendation_movie_animation"
    }
}
