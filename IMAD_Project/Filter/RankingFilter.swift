//
//  RankingFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 1/8/24.
//

import Foundation

enum RankingFilter:String,CaseIterable{
    
    case all
    case week
    case month
    
    var name:String{
        switch self{
        case .week:
            return "주간"
        case .month:
            return "월간"
        case .all:
            return "전체"
        }
    }
}

