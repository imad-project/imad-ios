//
//  RankingResponseList.swift
//  IMAD_Project
//
//  Created by 유영웅 on 1/8/24.
//

import Foundation

struct RankingResponseList: Codable,Hashable {
    let contentsID: Int
    let contentsType, title, posterPath: String
    let rankChanged: Int?
    let rank: Int

    enum CodingKeys: String, CodingKey {
        case contentsID = "contentsId"
        case contentsType, title, posterPath, rankChanged, rank
    }
}
