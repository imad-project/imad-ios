//
//  RegisterCheckFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 10/11/24.
//

import Foundation

enum RegisterCheckFilter{
    case emptyInfomation
    case emailFormatError
    case passwordFormatError
    case passwordMismatch
    case notConfirmDuplicate
    case changedEmail
    case success
    
    var message:String{
        switch self{
        case .emptyInfomation:
            return "입력하지 않은 정보가 있습니다!"
        case .emailFormatError:
            return "유효하지 않은 이메일입니다!"
        case .passwordFormatError:
            return "비밀번호는 영문 대,소문자, 숫자, 특수문자만 허용되며 8~20자 사이여야 합니다!"
        case .passwordMismatch:
            return "비밀번호가 일치하지 않습니다!"
        case .notConfirmDuplicate:
            return "이메일 중복확인을 해주세요!"
        case .changedEmail:
            return "이메일이 변경되었습니다. 중복확인을 다시 해주세요!"
        case .success:
            return ""
        }
    }
}
