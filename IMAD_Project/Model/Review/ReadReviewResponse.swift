//
//  ReadReviewResponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/07.
//

import Foundation

struct ReadReviewResponse:Codable,Hashable{
    let reviewID:Int
    let contentsID: Int
    let contentsTitle, contentsPosterPath: String
    let userID :Int?
    let userNickname: String
    let userProfileImage: Int
    let title, content: String
    let score:Double
    var likeCnt, dislikeCnt: Int
    let createdAt, modifiedAt: String
    var likeStatus: Int
    let spoiler: Bool
    let author:Bool

    enum CodingKeys: String, CodingKey {
        case reviewID = "review_id"
        case contentsID = "contents_id"
        case contentsTitle = "contents_title"
        case contentsPosterPath = "contents_poster_path"
        case userID = "user_id"
        case userNickname = "user_nickname"
        case userProfileImage = "user_profile_image"
        case title, content, score
        case likeCnt = "like_cnt"
        case dislikeCnt = "dislike_cnt"
        case createdAt = "created_at"
        case modifiedAt = "modified_at"
        case likeStatus = "like_status"
        case spoiler,author
    }
}
