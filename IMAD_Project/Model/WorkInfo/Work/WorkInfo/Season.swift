//
//  Season.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/08/21.
//

import Foundation

struct Season:Identifiable,Codable,Hashable{
    let airDate:String?
    let id:Int
    let name:String?
    let episodeCount:Int?
    let overview:String?
    let posterPath:String?
    let seasonNumber:Int?
    
    enum CodingKeys:String,CodingKey{
        case airDate = "air_date"
        case id
        case name
        case episodeCount = "episode_count"
        case overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
}
