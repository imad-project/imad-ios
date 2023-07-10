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
    case google
    
    var color:Color{
        switch self{
        case .Apple:
            return Color.black
        case .naver:
            return Color("naver")
        case .kakao:
            return Color("kakao")
        case .google:
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
        case .google:
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
        }
    }
}
