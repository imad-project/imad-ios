//
//  UserResponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/04.
//

import Foundation

// MARK: - 일반 로그인 및 회원정보 조회 data Response
struct UserResponse:Codable{
    
    var email:String
    var nickname:String?
    var gender:String?
    var birthYear:Int
    var profileImage:String
    var tvGenre:[Int]
    var movieGenre:[Int]
    let ageRange:Int
    let authProvider:String
    let role:String
    
    
    enum CodingKeys:String,CodingKey{
        case email
        case nickname
        case authProvider = "auth_provider"
        case gender
        case birthYear = "birth_year"
        case profileImage = "profile_image"
        case tvGenre = "preferred_tv_genres"
        case ageRange = "age_range"
        case movieGenre = "preferred_movie_genres"
        case role
    }
}
