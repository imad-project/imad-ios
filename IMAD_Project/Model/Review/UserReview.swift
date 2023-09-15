//
//  User.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/14.
//

import Foundation

struct UserReview:Codable,Hashable{
    let nickName:String
    let image:Int
    let comment:String
    let gradeAvg:Double
    let date:String
}
