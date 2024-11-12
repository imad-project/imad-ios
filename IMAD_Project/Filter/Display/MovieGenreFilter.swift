//
//  MovieGenreFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/08/14.
//

import Foundation

enum MovieGenreFilter: Int,CaseIterable {
    case action = 28
    case adventure = 12
    case animation = 16
    case comedy = 35
    case crime = 80
    case documentary = 99
    case drama = 18
    case family = 10751
    case fantasy = 14
    case history = 36
    case horror = 27
    case music = 10402
    case mystery = 9648
    case romance = 10749
    case scienceFiction = 878
    case tvMovie = 10770
    case thriller = 53
    case war = 10752
    case western = 37
    var name: String {
        switch self {
        case .action: return "액션"
        case .adventure: return "모험"
        case .animation: return "애니메이션"
        case .comedy: return "코미디"
        case .crime: return "범죄"
        case .documentary: return "다큐멘터리"
        case .drama: return "드라마"
        case .family: return "가족"
        case .fantasy: return "판타지"
        case .history: return "역사"
        case .horror: return "공포"
        case .music: return "음악"
        case .mystery: return "미스터리"
        case .romance: return "로맨스"
        case .scienceFiction: return "SF"
        case .tvMovie: return "TV 영화"
        case .thriller: return "스릴러"
        case .war: return "전쟁"
        case .western: return "서부"
        }
    }
    var image:String{
        switch self{
        case .family:
            return "👨‍👩‍👧‍👦"
        case .fantasy:
            return "🔮"
        case .horror:
            return "💀"
        case .crime:
            return "💰"
        case .comedy:
            return "🤹🏻‍♂️"
        case .documentary:
            return "🏔️"
        case .action:
            return "🕶️"
        case .romance:
            return "💋"
        case .music:
            return "🎼"
        case .adventure:
            return "🧳"
        case .animation:
            return "🧚🏻‍♀️"
        case .drama:
            return "🎬"
        case .mystery:
            return "🕵🏻"
        case .tvMovie:
            return "🎥"
        case .thriller:
            return "🔦"
        case .war:
            return "🪖"
        case .western:
            return "🤠"
        case .history:
            return "⏳"
        case .scienceFiction:
            return "🚀"
        }
    }
}
