//
//  ActivityRecommend.swift
//  IMAD_Project
//
//  Created by 유영웅 on 6/24/24.
//

import Foundation

struct ActivityRecommend:Codable{
    let status: Int
    let data: ActivityRecommendResponse?
    let message: String
}
