//
//  UserInfo.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/17.
//

import Foundation

// MARK: - 일반 로그인 및 회원정보 조회 data Response
struct UserInfo:Codable{
    let status:Int
    var data:UserResponse?
    let message:String
}
