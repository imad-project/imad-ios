//
//  ReadScrap.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/22.
//

import Foundation

struct ScrapList:Codable{
    var detailList: [ScrapListResponse]
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
