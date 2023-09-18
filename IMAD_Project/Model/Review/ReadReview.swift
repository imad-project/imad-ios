//
//  ReviewInfo.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/09/12.
//

import Foundation


struct ReadReview:Codable{
    var status:Int
    var data:ReadReviewResponse?
    var message:String
}

struct ReadReviewResponse:Codable{
    let reviewID, contentsID: Int
    let contentsPosterPath:String?
    let contentsTitle,userNickname: String
    let userProfileImage: Int
    let title, content: String
    let score: Double
    var likeCnt, dislikeCnt: Int
    let createdAt, modifiedAt: String
    let likeStatus: Int
    let spoiler: Bool
    
    enum CodingKeys: String, CodingKey {
        case reviewID = "review_id"
        case contentsID = "contents_id"
        case contentsTitle = "contents_title"
        case contentsPosterPath = "contents_poster_path"
        case userNickname = "user_nickname"
        case userProfileImage = "user_profile_image"
        case title, content, score
        case likeCnt = "like_cnt"
        case dislikeCnt = "dislike_cnt"
        case createdAt = "created_at"
        case modifiedAt = "modified_at"
        case likeStatus = "like_status"
        case spoiler
    }
}
