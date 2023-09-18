//
//  ReviewLike.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/09/18.
//

import Foundation

struct ReviewLike:Codable{
    
    let status:Int
    let data:Int?   //response가 항상 null값임
    let message:String
}
