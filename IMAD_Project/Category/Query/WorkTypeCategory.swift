//
//  TypeFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 6/24/24.
//

import Foundation

enum WorkTypeCategory:String,CaseIterable{
    case all
    case tv
    case movie
    case animation
    var name:String{
        switch self{
        case .animation: return "애니메이션"
        case .tv: return "시리즈"
        case .movie: return "영화"
        case .all: return "전체"
        }
    }
    var query:String{
        switch self{
        case .animation: "ANIMATION"
        case .tv: "TV"
        case .movie:"MOVIE"
        case .all:""
        }
    }
}
