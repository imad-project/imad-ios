//
//  KakaoAuth.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/06.
//

import Foundation

struct LoginResponse:Codable{
    
    let email:String
    let nickname:String?
    let authProvider:String
    let gender:String?
    let ageRange:Int
    
    enum CodingKeys:String,CodingKey{
        case email
        case nickname
        case authProvider = "auth_provider"
        case gender
        case ageRange = "age_range"
    }
}
