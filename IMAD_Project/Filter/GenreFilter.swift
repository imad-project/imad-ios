//
//  GenreFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/05.
//

import Foundation

enum MovieGenreFilter:String, CaseIterable{
    case family
    case fantasy
    case horror
    case crime
    case SF
    case comedy
    case documentary
    case action
    case romance
    case music
    case classic
    case adventure
    case animation
    case drama
    case mystery
    case movie
    case thriller
    case war
    case western
    
    
    var generName:String{
        switch self{
        case .family:
            return "가족"
        case .fantasy:
            return "판타지"
        case .horror:
            return "공포"
        case .crime:
            return "범죄"
        case .SF:
            return "SF"
        case .comedy:
            return "코미디"
        case .documentary:
            return "다큐멘터리"
        case .action:
            return "액션"
        case .romance:
            return "로맨스"
        case .music:
            return "음악"
        case .classic:
            return "역사"
        case .adventure:
            return "모험"
        case .animation:
            return "애니메이션"
        case .drama:
            return "드라마"
        case .mystery:
            return "미스터리"
        case .movie:
            return "TV 영화"
        case .thriller:
            return "스릴러"
        case .war:
            return "전쟁"
        case .western:
            return "서부"
        }
    }
}
