//
//  BookmarkDetailsList.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/04.
//

import Foundation

struct BookmarkResponse: Codable,Hashable {
    let bookmarkID, userID, contentsID: Int
    let contentsTitle,contentsPosterPath:String
    let createdDate: String

    enum CodingKeys: String, CodingKey {
        case bookmarkID = "bookmark_id"
        case userID = "user_id"
        case contentsID = "contents_id"
        case createdDate = "created_date"
        case contentsTitle = "contents_title"
        case contentsPosterPath = "contents_poster_path"
    }
}
