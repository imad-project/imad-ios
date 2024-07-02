//
//  ImadRecommend.swift
//  IMAD_Project
//
//  Created by 유영웅 on 6/24/24.
//

import Foundation

struct ImadRecommend:Codable{
    let status: Int
    let data: ImadRecommendResponse?
    let message: String
}
