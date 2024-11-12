//
//  EmailCheckFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 10/11/24.
//

import Foundation

enum EmailCheckFilter{
    case emptyInfomation
    case emailFormatError
    case success
    var message:String{
        switch self{
        case .emptyInfomation:
            return "이메일을 입력해주세요"
        case .emailFormatError:
            return "유효하지 않은 이메일입니다!"
        case .success:
            return ""
        }
    }
}
