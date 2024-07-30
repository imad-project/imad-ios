//
//  PopularPostingResponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 3/8/24.
//

import Foundation

struct PopularPostingResponse:Codable{
    let postingID, contentsID: Int
    let contentsTitle, contentsPosterPath, contentsBackdropPath: String?
    let userID: Int
    let userNickname, userProfileImage, title, content: String?
    let category, viewCnt, likeCnt, dislikeCnt: Int
    let likeStatus: Int
    let createdAt, modifiedAt: String
    let commentCnt: Int
    let commentListResponse: CommentListResponse
    let scrapID: Int?
    var reported:Bool?
    let scrapStatus, author, spoiler: Bool
    
    enum CodingKeys: String, CodingKey {
        case postingID = "posting_id"
        case contentsID = "contents_id"
        case contentsTitle = "contents_title"
        case contentsPosterPath = "contents_poster_path"
        case contentsBackdropPath = "contents_backdrop_path"
        case userID = "user_id"
        case userNickname = "user_nickname"
        case userProfileImage = "user_profile_image"
        case title, content, category
        case viewCnt = "view_cnt"
        case likeCnt = "like_cnt"
        case dislikeCnt = "dislike_cnt"
        case likeStatus = "like_status"
        case createdAt = "created_at"
        case modifiedAt = "modified_at"
        case commentCnt = "comment_cnt"
        case commentListResponse = "comment_list_response"
        case scrapID = "scrap_id"
        case scrapStatus = "scrap_status"
        case reported,author, spoiler
    }
}
