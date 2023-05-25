//
//  RegisterResponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/13.
//

import Foundation

struct RegisterResponse:Codable{
    let data:LoginResponse?
    let statusCode:Int
    let message:String?
    
    enum CodingKeys:String,CodingKey{
        case data
        case statusCode = "status"
        case message
    }
}


