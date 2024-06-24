//
//  TrendRecommend.swift
//  IMAD_Project
//
//  Created by 유영웅 on 6/24/24.
//

import Foundation

struct TrendRecommend:Codable{
    let status: Int
    let data: TrendRecommendResponse?
    let message: String
}
