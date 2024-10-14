//
//  NickNameCheckFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 10/11/24.
//

import Foundation

enum NicknameCheckFilter{
    case emptyInfomation
    case nicknameFormatError
    case notConfirmDuplicate
    case changedNickname
    case success
    
    var message:String{
        switch self{
        case .emptyInfomation:
            return "닉네임을 입력해주세요"
        case .nicknameFormatError:
            return "유효하지 않은 닉네임입니다!"
        case .notConfirmDuplicate:
            return "닉네임을 중복확인을 해주세요!"
        case .changedNickname:
            return "닉네임이 변경되었습니다. 중복확인을 다시 해주세요!"
        case .success:
            return ""
        }
    }
}
