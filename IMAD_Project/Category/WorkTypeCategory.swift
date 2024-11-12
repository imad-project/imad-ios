//
//  MovieTypeFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/08/11.
//

import Foundation

enum WorkTypeCategory:String,CaseIterable{
    case multi
    case tv
    case movie
    var name:String{
        switch self{
        case .multi:
            return "전체"
        case .tv:
            return "시리즈/TV"
        case .movie:
            return "영화"
        }
    }
}
