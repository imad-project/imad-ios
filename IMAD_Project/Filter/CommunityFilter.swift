//
//  CommunityFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/06.
//

import Foundation

enum CommunityFilter:CaseIterable{
    case free
    case question
    case debate
    
    var name:String {
        switch self{
        case .free:
            return "자유글"
        case .question:
            return "질문글"
        case .debate:
            return "토론글"
        }
    }
}
