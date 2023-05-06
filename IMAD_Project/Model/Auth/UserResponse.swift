//
//  Login.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/06.
//

import Foundation

struct UserResponse:Codable{
    
    let id:String
    let email:String
    let nickname:String
    let ageRange:String
    let gender:String
    let image:String
}
