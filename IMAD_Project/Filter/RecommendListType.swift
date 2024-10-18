//
//  RecommendListType.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/1/24.
//

import Foundation

enum RecommendListType{
    case genreTv
    case genreMovie
    case trendTv
    case trendMovie
    case activityTv
    case activityAnimationTv
    case activityMovie
    case activityAnimationMovie
    case imadTv
    case imadMovie
    
    var name:String{
        switch self{
        case .genreTv,.trendTv,.imadTv,.activityTv: "시리즈"
        case .genreMovie,.trendMovie,.imadMovie,.activityMovie: "영화"
        case .activityAnimationTv : "애니메이션 시리즈"
        case .activityAnimationMovie :"애니메이션 영화"
        }
    }
    var type:WorkGenreType{
        switch self{
        case .genreTv,.imadTv,.trendTv,.activityTv,.activityAnimationTv: return .tv
        case .genreMovie,.imadMovie,.trendMovie,.activityMovie,.activityAnimationMovie: return .movie
        }
    }
}
