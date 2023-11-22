//
//  ScrapListResponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/22.
//

import Foundation

struct ScrapListResponse:Codable,Hashable{
    let scrapId:Int
    let userId:Int
    let postingId:Int                // 게시글 ID
    let postingTitle:String        // 게시글 제목
    let createdDate:String
    
    enum CodingKeys:String,CodingKey{
        case scrapId = "scrap_id"
        case userId = "user_id"
        case postingId = "posting_id"
        case postingTitle = "posting_title"
        case createdDate = "created_date"
    }
}
