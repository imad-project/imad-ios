//
//  CommunityFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/06.
//

import Foundation

enum CommunityFilter:CaseIterable{
    case all
    case free
    case question
    case debate
    
    var name:String {
        switch self{
        case .all:
            return "전체글"
        case .free:
            return "자유글"
        case .question:
            return "질문글"
        case .debate:
            return "토론글"
        }
    }
    var image:String{
        switch self{
        case .all:
            return ""
        case .free:
            return "🌈"
        case .question:
            return "🤷‍♂️"
        case .debate:
            return "🤔"
        }
    }
    var num:Int {
        switch self{
        case .all:
            return 0
        case .free:
            return 1
        case .question:
            return 2
        case .debate:
            return 3
        }
    }
}
