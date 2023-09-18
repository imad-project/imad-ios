//
//  ReadReviewList.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/09/15.
//

import Foundation

struct ReadReviewList: Codable {
    let status: Int
    let data: ReviewDetails?
    let message: String
}


struct ReviewDetails: Codable,Hashable {
    
    var reviewDetailsResponseList: [ReviewDetailsResponseList]?
    let totalElements, totalPages, pageNumber, numberOfElements: Int?
    let sizeOfPage, sortDirection: Int?
    let sortProperty: String?

    enum CodingKeys: String, CodingKey {
        case reviewDetailsResponseList = "review_details_response_list"
        case totalElements = "total_elements"
        case totalPages = "total_pages"
        case pageNumber = "page_number"
        case numberOfElements = "number_of_elements"
        case sizeOfPage = "size_of_page"
        case sortDirection = "sort_direction"
        case sortProperty = "sort_property"
    }
}

// MARK: - ReviewDetailsResponseList
struct ReviewDetailsResponseList: Codable,Hashable {
    let reviewID, contentsID: Int
    let contentsTitle, contentsPosterPath: String
    let userID :Int?
    let userNickname: String
    let userProfileImage: Int
    let title, content: String
    let score:Double
    var likeCnt, dislikeCnt: Int
    let createdAt, modifiedAt: String
    let likeStatus: Int
    let spoiler: Bool

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
        case spoiler
    }
}
