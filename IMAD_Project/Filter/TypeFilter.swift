//
//  TypeFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 6/24/24.
//

import Foundation

enum TypeFilter:String,CaseIterable{
    case animation = "ANIMATION"
    case tv = "TV"
    case movie = "MOVIE"
    
    var name:String{
        switch self{
        case .animation: return "애니메이션"
        case .tv: return "시리즈"
        case .movie: return "영화"
        }
    }
}
