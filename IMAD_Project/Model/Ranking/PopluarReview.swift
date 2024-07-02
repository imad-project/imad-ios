//
//  PopluarReview.swift
//  IMAD_Project
//
//  Created by 유영웅 on 3/8/24.
//

import Foundation

struct PopluarReview:Codable{
    let status: Int
    var data: PopularReviewResponse?
    let message: String
}
