//
//  RecommendListType.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/1/24.
//

import Foundation

enum RecommendListType:CaseIterable{
    case genreTv
    case genreMovie
    case trendTv
    case trendMovie
    case activityTv
    case activityAnimationTv
    case activityMovie
    case activityAnimationMovie
    case topRateTv
    case topRateMovie
    case popluarTv
    case popluarMovie
    
    var name:String{
        switch self{
        case .genreTv,.trendTv,.topRateTv,.popluarTv,.activityTv: "시리즈"
        case .genreMovie,.trendMovie,.topRateMovie,.popluarMovie,.activityMovie: "영화"
        case .activityAnimationTv : "애니메이션 시리즈"
        case .activityAnimationMovie :"애니메이션 영화"
        }
    }
    var type:WorkGenreType{
        switch self{
        case .genreTv,.topRateTv,.popluarTv,.trendTv,.activityTv,.activityAnimationTv: return .tv
        case .genreMovie,.topRateMovie,.popluarMovie,.trendMovie,.activityMovie,.activityAnimationMovie: return .movie
        }
    }
    var option:[RecommendListType]{
        switch self{
        case .activityTv,.activityMovie,.activityAnimationTv,.activityAnimationMovie:
            return [self]
        case .genreTv,.genreMovie:
            return [.genreTv,.genreMovie]
        case .popluarTv,.popluarMovie:
            return [.popluarTv,.popluarMovie]
        case .topRateTv,.topRateMovie:
            return [.topRateTv,.topRateMovie]
        case .trendTv,.trendMovie:
            return [.trendTv,.trendMovie]
        }
    }
}
