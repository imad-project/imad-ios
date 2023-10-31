//
//  CommunityList.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/16.
//

import Foundation


struct CommunityList: Codable {
    let status: Int
    var data: CommunityDetails?
    let message: String
}


struct CommunityDetails: Codable,Hashable {
    
    var postingDetailsResponseList: [CommuityDetailsResponseList]?
    let totalElements, totalPages, pageNumber, numberOfElements: Int
    let sizeOfPage, sortDirection: Int
    let sortProperty: String
    let searchType: Int
    
    enum CodingKeys: String, CodingKey {
        case postingDetailsResponseList = "posting_details_response_list"
        case totalElements = "total_elements"
        case totalPages = "total_pages"
        case pageNumber = "page_number"
        case numberOfElements = "number_of_elements"
        case sizeOfPage = "size_of_page"
        case sortDirection = "sort_direction"
        case sortProperty = "sort_property"
        case searchType = "search_type"
    }
}


struct CommuityDetailsResponseList: Codable,Hashable {
    let postingID, contentsID: Int
    let contentsTitle, contentsPosterPath: String?
    let userID: Int
    let userNickname: String
    let userProfileImage: Int
    let title: String
    let category, viewCnt, likeCnt, dislikeCnt: Int
    let likeStatus: Int
    let commentCnt:Int
    let createdAt, modifiedAt: String
    let spoiler: Bool
    
    enum CodingKeys: String, CodingKey {
        case postingID = "posting_id"
        case contentsID = "contents_id"
        case contentsTitle = "contents_title"
        case contentsPosterPath = "contents_poster_path"
        case userID = "user_id"
        case userNickname = "user_nickname"
        case userProfileImage = "user_profile_image"
        case title, category
        case viewCnt = "view_cnt"
        case likeCnt = "like_cnt"
        case dislikeCnt = "dislike_cnt"
        case likeStatus = "like_status"
        case createdAt = "created_at"
        case modifiedAt = "modified_at"
        case spoiler
        case commentCnt = "comment_cnt"
    }
}

