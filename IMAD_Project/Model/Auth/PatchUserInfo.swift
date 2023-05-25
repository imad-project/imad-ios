//
//  PatchUserInfo.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/17.
//

import Foundation

struct PatchUserInfo:Codable{   //requset 전용
    var nickname:String
    var gender:String?
    var ageRange:Int?
    var genre:String?
    var image:Int
    
    enum CodingKeys:String,CodingKey{
        case nickname
        case gender
        case ageRange = "age_range"
        case genre
        case image = "profile_image"
    }
}
