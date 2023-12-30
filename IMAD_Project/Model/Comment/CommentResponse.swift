//
//  CommentResponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/17.
//

import Foundation


struct CommentResponse: Codable,Hashable {
    let commentID, userID: Int
    let postingId:Int
    let userNickname: String
    let userProfileImage: Int
    let parentID: Int?
    var content: String?
    let childCnt:Int
    var likeStatus, likeCnt, dislikeCnt: Int
    let createdAt, modifiedAt: String
    var removed: Bool

    enum CodingKeys: String, CodingKey {
        case commentID = "comment_id"
        case userID = "user_id"
        case postingId = "posting_id"
        case userNickname = "user_nickname"
        case userProfileImage = "user_profile_image"
        case parentID = "parent_id"
        case content
        case childCnt = "child_cnt"
        case likeStatus = "like_status"
        case likeCnt = "like_cnt"
        case dislikeCnt = "dislike_cnt"
        case createdAt = "created_at"
        case modifiedAt = "modified_at"
        case removed
    }
}
