//
//  CommentListReponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/23.
//

import Foundation

struct CommentListResponse:Codable,Hashable {
    let detailsList: [CommentResponse]
    let totalElements, totalPages, pageNumber, numberOfElements: Int
    let sizeOfPage, sortDirection: Int
    let sortProperty: String

    enum CodingKeys: String, CodingKey {
        case detailsList = "details_list"
        case totalElements = "total_elements"
        case totalPages = "total_pages"
        case pageNumber = "page_number"
        case numberOfElements = "number_of_elements"
        case sizeOfPage = "size_of_page"
        case sortDirection = "sort_direction"
        case sortProperty = "sort_property"
    }
}
