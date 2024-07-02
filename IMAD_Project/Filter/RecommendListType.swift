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
    
    var title:String{
        switch self{
        case .genreTv,.genreMovie: "내가 선호한 장르의 작품들"
        case .trendTv,.trendMovie: "요즘 뜨고 있는 작품들"
        case .imadTv,.imadMovie: "아이매드가 직접 엄선한 작품들"
        case .activityTv,.activityMovie,.activityAnimationTv,.activityAnimationMovie: "내가 좋아할 작품들"
        }
    }
    var name:String{
        switch self{
        case .genreTv,.trendTv,.imadTv,.activityTv: "시리즈"
        case .genreMovie,.trendMovie,.imadMovie,.activityMovie: "영화"
        case .activityAnimationTv : "애니메이션 시리즈"
        case .activityAnimationMovie :"애니메이션 영화"
        }
    }
}
