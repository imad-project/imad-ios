//
//  Vaildation.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/28.
//

import Foundation

struct Validation:Codable{
    let status:Int
    let data:ValidationResponse?
    let message:String?
}
