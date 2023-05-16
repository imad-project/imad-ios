//
//  RegisterResponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/13.
//

import Foundation

struct RegisterResponse:Codable{
    let code:String
    let statusCode:Int
    let message:String
    
    enum CodingKeys:String,CodingKey{
        case code
        case statusCode = "status_code"
        case message
    }
}
