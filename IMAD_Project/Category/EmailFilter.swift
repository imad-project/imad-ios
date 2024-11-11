//
//  EmailFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/30.
//

import Foundation

enum EmailDomainCategory:CaseIterable{
    case gmail
    case naver
    case hanmail
    case daum
    case outlook
    case nate
    var domain:String{
        switch self{
        case .gmail:
            return "gmail.com"
        case .naver:
            return "naver.com"
        case .hanmail:
            return "hanmail.net"
        case .nate:
            return "nate.com"
        case .daum:
            return "daum.net"
        case .outlook:
            return "outlook.com"
        }
    }
}
