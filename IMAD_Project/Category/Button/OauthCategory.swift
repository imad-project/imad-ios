//
//  OauthFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/16.
//

import Foundation
import SwiftUI

enum OauthCategory:String,Identifiable,CaseIterable{
    case Apple
    case naver
    case kakao
    case google
    case none
    var id:UUID{
        UUID(uuidString: self.rawValue) ?? UUID()
    }
    var color:Color{
        switch self{
        case .Apple:
            return Color.black
        case .naver:
            return Color("naver")
        case .kakao:
            return Color("kakao").opacity(0.7)
        case .google:
            return Color.white
        case .none :
            return Color.black
        }
    }
    var textColor:Color{
        switch self{
        case .Apple:
            return Color.white
        case .naver:
            return Color.white
        case .kakao:
            return Color.black
        case .google:
            return Color.black
        case .none :
            return Color.black
        }
    }
    var text:String{
        switch self{
        case .Apple:
            return "Apple로 계속하기"
        case .naver:
            return "네이버로 계속하기"
        case .kakao:
            return "카카오로 계속하기"
        case .google:
            return "Google로 계속하기"
        case .none :
            return ""
        }
    }
    var authProvierName:String{
        switch self{
        case .Apple:
            return "apple"
        case .google,.kakao,.naver,.none:
            return rawValue
        }
    }
}
