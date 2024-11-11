//
//  WorkFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/06/02.
//

import Foundation

enum WorkFilter:CaseIterable{
    case work
    case review
    
    var name:String {
        switch self{
        case .work:
            return "작품정보"
        case .review:
            return "리뷰"
        }
    }
}
