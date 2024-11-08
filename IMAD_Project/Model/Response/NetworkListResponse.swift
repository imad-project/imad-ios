//
//  NetworkListResponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 11/8/24.
//

import Foundation

struct NetworkListResponse<T:Codable&Hashable>:Codable&Hashable{
    var detailList: [T]
    let totalElements, totalPages, pageNumber, numberOfElements: Int
    let sizeOfPage, sortDirection: Int
    let sortProperty: String?
    let searchType: Int?
    
    enum CodingKeys: String, CodingKey {
        case detailList = "details_list"
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
