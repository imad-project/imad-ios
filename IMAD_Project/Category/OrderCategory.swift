//
//  ReviewOrderFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/09/15.
//

import Foundation

enum OrderCategory:Int,CaseIterable{
    case ascending = 0
    case descending = 1
    var name:String{
        switch self{
        case .ascending:
            return "오름차순"
        case .descending:
            return "내림차순"
        }
    }
    
}
