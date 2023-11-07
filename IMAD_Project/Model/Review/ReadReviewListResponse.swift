//
//  ReadReviewListResponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/07.
//

import Foundation

struct ReadReviewListResponse: Codable,Hashable {
    
    var reviewDetailsResponseList: [ReadReviewResponse]
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
