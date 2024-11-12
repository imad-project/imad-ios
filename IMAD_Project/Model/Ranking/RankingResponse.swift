//
//  RankingResponseList.swift
//  IMAD_Project
//
//  Created by 유영웅 on 1/8/24.
//

import Foundation

struct RankingResponse: Codable,Hashable {
    let id = UUID()
    let contentsID: Int
    let contentsType: String
    let imadScore: Double?
    let title, posterPath: String
    let ranking:Int
    let rankingChanged: Int?
    
    enum CodingKeys: String, CodingKey {
        case contentsID = "contents_id"
        case contentsType = "contents_type"
        case imadScore = "imad_score"
        case title
        case posterPath = "poster_path"
        case ranking
        case rankingChanged = "ranking_changed"
    }
}
