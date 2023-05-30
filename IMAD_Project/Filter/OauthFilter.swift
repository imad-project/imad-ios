//
//  OauthFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/16.
//

import Foundation
import SwiftUI

enum OauthFilter:String,CaseIterable{
    case Apple
    case naver
    case kakao
    case Google
    
    var color:Color{
        switch self{
        case .Apple:
            return Color.black
        case .naver:
            return Color("naver")
        case .kakao:
            return Color("kakao")
        case .Google:
            return Color.white
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
        case .Google:
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
        case .Google:
            return "Google로 계속하기"
        }
    }
}
