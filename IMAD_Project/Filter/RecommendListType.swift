//
//  RecommendListType.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/1/24.
//

import Foundation

enum RecommendListType:String{
    case genreTv
    case genreMovie
    case trendTv
    case trendMovie
    case activityTv  = "시리즈"
    case activityAnimationTv = "애니메이션 시리즈"
    case activityMovie = "영화"
    case activityAnimationMovie = "애니메이션 영화"
    case imadTv
    case imadMovie
}
