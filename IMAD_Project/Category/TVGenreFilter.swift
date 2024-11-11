//
//  TVGenreFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/08/14.
//

import Foundation

enum TVGenreFilter: Int,CaseIterable {
    case actionAdventure = 10759
    case animation = 16
    case comedy = 35
    case crime = 80
    case documentary = 99
    case drama = 18
    case family = 10751
    case kids = 10762
    case mystery = 9648
    case news = 10763
    case reality = 10764
    case sciFiFantasy = 10765
    case soap = 10766
    case talk = 10767
    case warPolitics = 10768
    case western = 37
    
    var name: String {
        switch self {
        case .actionAdventure: return "액션&어드벤쳐"
        case .animation: return "애니메이션"
        case .comedy: return "코미디"
        case .crime: return "범죄"
        case .documentary: return "다큐멘터리"
        case .drama: return "드라마"
        case .family: return "가족"
        case .kids: return "아동"
        case .mystery: return "미스터리"
        case .news: return "뉴스"
        case .reality: return "리얼리티"
        case .sciFiFantasy: return "SF/판타지"
        case .soap: return "소프 오페라"
        case .talk: return "토크"
        case .warPolitics: return "전쟁/정치"
        case .western: return "서부"
        }
    }
    var image:String{
        switch self{
        case .family:
            return "👨‍👩‍👧‍👦"
        case .crime:
            return "💰"
        case .comedy:
            return "🤹🏻‍♂️"
        case .documentary:
            return "🏔️"
        case .animation:
            return "🧚🏻‍♀️"
        case .drama:
            return "🎬"
        case .mystery:
            return "🕵🏻"
        case .western:
            return "🤠"
        case .actionAdventure:
            return "😎"
        case .kids:
            return "👶🏻"
        case .news:
            return "📰"
        case .reality:
            return "🎯"
        case .sciFiFantasy:
            return "🚀"
        case .soap:
            return "🎶"
        case .talk:
            return "🎤"
        case .warPolitics:
            return "🪖"
        }
    }
}
