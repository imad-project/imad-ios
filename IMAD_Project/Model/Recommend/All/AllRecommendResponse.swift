//
//  AllRecommendResponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 6/24/24.
//

import Foundation


struct AllRecommendResponse: Codable {
    var preferredGenreRecommendationTv: RecommendList?
    var preferredGenreRecommendationMovie: RecommendList?
    var userActivityRecommendationTv, userActivityRecommendationMovie, userActivityRecommendationTvAnimation, userActivityRecommendationMovieAnimation: RecommendList?
    var popularRecommendationTv: RecommendList?
    var popularRecommendationMovie: RecommendList?
    var topRatedRecommendationTv: RecommendList?
    var topRatedRecommendationMovie: RecommendList?
    var trendRecommendationTv: RecommendList?
    var trendRecommendationMovie: RecommendList?

    enum CodingKeys: String, CodingKey {
        case preferredGenreRecommendationTv = "preferred_genre_recommendation_tv"
        case preferredGenreRecommendationMovie = "preferred_genre_recommendation_movie"
        case userActivityRecommendationTv = "user_activity_recommendation_tv"
        case userActivityRecommendationMovie = "user_activity_recommendation_movie"
        case userActivityRecommendationTvAnimation = "user_activity_recommendation_tv_animation"
        case userActivityRecommendationMovieAnimation = "user_activity_recommendation_movie_animation"
        case popularRecommendationTv = "popular_recommendation_tv"
        case popularRecommendationMovie = "popular_recommendation_movie"
        case topRatedRecommendationTv = "top_rated_recommendation_tv"
        case topRatedRecommendationMovie = "top_rated_recommendation_movie"
        case trendRecommendationTv = "trend_recommendation_tv"
        case trendRecommendationMovie = "trend_recommendation_movie"
    }
}
