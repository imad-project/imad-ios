//
//  ReviewSortFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/09/15.
//

import Foundation

enum SortPostCategory:String,CaseIterable{
    case score
    case createdDate
    case likeCnt
    case dislikeCnt
    var name:String{
        switch self{
        case .score:
            return "평점 순"
        case .createdDate:
            return "날짜 순"
        case .likeCnt:
            return "좋아요 순"
        case .dislikeCnt:
            return "싫어요 순"
        }
    }
}
