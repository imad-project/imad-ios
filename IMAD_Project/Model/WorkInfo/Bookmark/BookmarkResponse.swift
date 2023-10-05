//
//  BookmarkResponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/04.
//

import Foundation

struct BookmarkResponse: Codable,Hashable {
    let bookmarkDetailsList: [BookmarkDetailsList]?
    let totalElements, totalPages, pageNumber, numberOfElements: Int
    let sizeOfPage, sortDirection: Int
    let sortProperty: Int?

    enum CodingKeys: String, CodingKey {
        case bookmarkDetailsList = "bookmark_details_list"
        case totalElements = "total_elements"
        case totalPages = "total_pages"
        case pageNumber = "page_number"
        case numberOfElements = "number_of_elements"
        case sizeOfPage = "size_of_page"
        case sortDirection = "sort_direction"
        case sortProperty = "sort_property"
    }
}


