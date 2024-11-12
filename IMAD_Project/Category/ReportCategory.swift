//
//  ReportFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/19/24.
//

import Foundation

enum ReportCategory:String,CaseIterable{
    case wrongInfo = "WRONG_INFO"
    case spam = "SPAM"
    case abusive = "ABUSIVE"
    case inappropriate = "INAPPROPRIATE"
    case coprightViolation = "COPYRIGHT_VIOLATION"
    case other = "OTHER"
    var name:String{
        switch self{
        case .wrongInfo:
            "잘못된 정보"
        case .spam:
            "스팸, 상업적 광고"
        case .abusive:
            "폭력적이거나 공격적인 내용"
        case .inappropriate:
            "부적절한 내용(성적인 컨텐츠, 혐오발언 등)"
        case .coprightViolation:
            "저작권 침해"
        case .other:
            "기타"
        }
    }
}
