//
//  ProfileResponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 12/16/23.
//

import Foundation

struct ProfileResponse:Codable{
    let userID: Int
    let userNickname: String
    var userProfileImage:String?
    let myReviewCnt, myPostingCnt, myScrapCnt: Int
    let bookmarkListResponse: BookmarkResponse

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userNickname = "user_nickname"
        case userProfileImage = "user_profile_image"
        case myReviewCnt = "my_review_cnt"
        case myPostingCnt = "my_posting_cnt"
        case myScrapCnt = "my_scrap_cnt"
        case bookmarkListResponse = "bookmark_list_response"
    }
}
