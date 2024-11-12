//
//  RecommendListType.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/1/24.
//

import Foundation

enum RecommendCategory:String,CaseIterable{
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
    var endPoint:String{
        switch self{
        case .genreTv,.genreMovie:"genre"
        case .trendTv,.trendMovie:"trend"
        case .topRateTv,.topRateMovie,.popluarTv,.popluarMovie:"imad"
        case .activityTv,.activityMovie,.activityAnimationTv,.activityAnimationMovie:"activity"
        }
    }
    var type:GenreType{
        switch self{
        case .genreTv,.topRateTv,.popluarTv,.trendTv,.activityTv,.activityAnimationTv: return .tv
        case .genreMovie,.topRateMovie,.popluarMovie,.trendMovie,.activityMovie,.activityAnimationMovie: return .movie
        }
    }
    var option:[RecommendCategory]{
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
    var title:String{
        switch self{
        case .genreTv:return "님을 위한 시리즈"
        case .genreMovie:return "이런 장르 영화 어때요?"
        case .trendTv:return "인기 시리즈"
        case .trendMovie:return "인기 영화"
        case .popluarTv:return "어머! 이건 꼭 봐야 해"
        case .popluarMovie:return "아이매드 엄선 영화"
        case .topRateTv:return "전 세계 사람들이 선택한 시리즈"
        case .topRateMovie:return "좋은반응을 얻은 영화"
        default:return ""
        }
    }
}
