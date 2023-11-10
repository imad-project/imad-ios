//
//  ReadReviewList.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/09/15.
//

import Foundation

struct ReadReviewList: Codable {
    let status: Int
    var data: ReadReviewListResponse?
    let message: String
}


