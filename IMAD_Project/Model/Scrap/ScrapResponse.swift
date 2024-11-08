//
//  ScrapListResponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/22.
//

import Foundation

struct ScrapResponse:Codable,Hashable{
    let scrapID, userID: Int
    let userNickname: String
    let userProfileImage:String
    let contentsID: Int
    let contentsTitle, contentsPosterPath: String
    let postingID: Int
    let postingTitle, createdDate: String
    
    enum CodingKeys: String, CodingKey {
        case scrapID = "scrap_id"
        case userID = "user_id"
        case userNickname = "user_nickname"
        case userProfileImage = "user_profile_image"
        case contentsID = "contents_id"
        case contentsTitle = "contents_title"
        case contentsPosterPath = "contents_poster_path"
        case postingID = "posting_id"
        case postingTitle = "posting_title"
        case createdDate = "created_date"
    }
}
