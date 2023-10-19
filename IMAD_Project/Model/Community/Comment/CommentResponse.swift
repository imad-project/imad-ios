//
//  CommentResponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/17.
//

import Foundation

struct CommentResponse: Codable,Hashable {
    let commentID, userID: Int
    let userNickname: String
    let userProfileImage: Int
    let parentID: Int?
    let content:String?
    let createdAt, modifiedAt: String
    let removed: Bool

    enum CodingKeys: String, CodingKey {
        case commentID = "comment_id"
        case userID = "user_id"
        case userNickname = "user_nickname"
        case userProfileImage = "user_profile_image"
        case parentID = "parent_id"
        case content
        case createdAt = "created_at"
        case modifiedAt = "modified_at"
        case removed
    }
}
