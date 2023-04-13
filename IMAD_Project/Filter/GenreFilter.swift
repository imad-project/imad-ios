//
//  GenreFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/05.
//

import Foundation

enum GenerFilter:String, CaseIterable{
    case family
    case fantasy
    case horror
    case crime
    case SF
    case comedy
    case world
    case documentary
    case action
    case romance
    case music
    case classic
    
    var generName:String{
        switch self{
        case .family:
            return "가족/키즈"
        case .fantasy:
            return "판타지/마법"
        case .horror:
            return "공포/호러"
        case .crime:
            return "범죄/추리"
        case .SF:
            return "SF/공상과학"
        case .comedy:
            return "코미디/개그"
        case .world:
            return "해외"
        case .documentary:
            return "다큐멘터리"
        case .action:
            return "액션/누아르"
        case .romance:
            return "로맨스/애로"
        case .music:
            return "뮤직"
        case .classic:
            return "고전/신화"
        }
    }
}
