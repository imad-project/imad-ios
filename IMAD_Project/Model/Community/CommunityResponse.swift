//
//  CommunityResponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/10.
//

import Foundation

struct CommunityResponse:Codable,Hashable{
    
    let postingID, contentsID: Int
    let contentsTitle, contentsPosterPath: String
    let userID: Int
    let userNickname: String
    let userProfileImage: Int
    let title, content: String
    let category, viewCnt:Int
    var likeCnt, dislikeCnt: Int
    var likeStatus: Int
    let createdAt, modifiedAt: String
    let commentCnt: Int
    var commentListResponse: CommentListResponse?
    var scrapId:Int?
    var scrapStatus:Bool
    var author:Bool
    let spoiler: Bool
    
    enum CodingKeys: String, CodingKey {
        case postingID = "posting_id"
        case contentsID = "contents_id"
        case contentsTitle = "contents_title"
        case contentsPosterPath = "contents_poster_path"
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
        case scrapId = "scrap_id"
        case scrapStatus = "scrap_status"
        case spoiler,author
    }
}
