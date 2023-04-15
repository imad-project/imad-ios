//
//  Review.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/14.
//

import Foundation

struct Review:Codable,Hashable{
    let title:String
    let thumbnail:String
    let desc:String
    let genre:String
    let opendDate:String
    let gradeAvg:Double
}

struct Genre:Codable{
    
}
