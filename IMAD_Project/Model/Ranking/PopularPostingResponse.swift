//
//  PopularPostingResponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 3/8/24.
//

import Foundation

struct PopularPostingResponse:Codable{
    let postingID, contentsID: Int
    let contentsTitle:String
    let contentsPosterPath,contentsBackdropPath: String
    let userID: Int
    let userNickname: String
    let userProfileImage: Int
    let title: String
    let content:String
    let category, viewCnt, commentCnt, likeCnt: Int
    let dislikeCnt, likeStatus: Int
    let createdAt, modifiedAt: String
    let scrapID: Int?
    let scrapStatus, spoiler: Bool
    
    enum CodingKeys: String, CodingKey {
        case postingID = "posting_id"
        case contentsID = "contents_id"
        case contentsTitle = "contents_title"
        case contentsPosterPath = "contents_poster_path"
        case contentsBackdropPath = "contents_backdrop_path"
        case userID = "user_id"
        case userNickname = "user_nickname"
        case userProfileImage = "user_profile_image"
        case title, category,content
        case viewCnt = "view_cnt"
        case commentCnt = "comment_cnt"
        case likeCnt = "like_cnt"
        case dislikeCnt = "dislike_cnt"
        case likeStatus = "like_status"
        case createdAt = "created_at"
        case modifiedAt = "modified_at"
        case scrapID = "scrap_id"
        case scrapStatus = "scrap_status"
        case spoiler
    }
}
