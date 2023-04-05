//
//  GenreFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/05.
//

import Foundation

enum GenerFilter:CaseIterable{
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
    case clasic
    
    var generName:String{
        switch self{
        case .family:
            return "가족"
        case .fantasy:
            return "판타지"
        case .horror:
            return "공포/호러"
        case .crime:
            return "범죄/추리"
        case .SF:
            return "SF"
        case .comedy:
            return "코미디"
        case .world:
            return "해외"
        case .documentary:
            return "다큐멘터리"
        case .action:
            return "액션"
        case .romance:
            return "로맨스"
        case .music:
            return "뮤직"
        case .clasic:
            return "고전"
        }
    }
}
