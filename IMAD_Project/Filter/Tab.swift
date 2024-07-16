//
//  Tab.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/05.
//

import Foundation

enum Tab:String,CaseIterable{
    case home
    case community
    case notification
    case profile
    
    var name:String {
        switch self{
        case .home:
            return "house"
        case .community:
            return "quote.closing"
        case .notification:
            return "magnifyingglass"
        case .profile:
            return ""
        }
    }
    var menu:String{
        switch self{
        case .home:
            return "홈"
        case .community:
            return "커뮤니티"
        case .notification:
            return "작품 찾기"
        case .profile:
            return "내 프로필"
        }
    }
    
}
