//
//  BookmarkDetailsList.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/04.
//

import Foundation

struct BookmarkDetailsList: Codable {
    let bookmarkID, userID, contentsID: Int
    let createdDate: String

    enum CodingKeys: String, CodingKey {
        case bookmarkID = "bookmark_id"
        case userID = "user_id"
        case contentsID = "contents_id"
        case createdDate = "created_date"
    }
}
