//
//  UserInfo.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/17.
//

import Foundation


struct GetUserInfo:Codable{
    let status:Int
    var data:LoginResponse?
    let message:String?
}
