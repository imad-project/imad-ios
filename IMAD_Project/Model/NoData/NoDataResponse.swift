//
//  NoDataResponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/04.
//

import Foundation

// MARK: - 아무런 데이터도 들어오지 않는게 확정일 경우
// 회원가입 response : /api/signup
// 토큰 재발급 response : /api/token
// 비밀번호 수정 response : /api/user/password
 
struct NoDataResponse:Codable{
    let status:Int
    var data:Int? = nil
    let message:String
}
