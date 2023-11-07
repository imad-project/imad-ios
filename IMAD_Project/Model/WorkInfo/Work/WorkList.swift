//
//  WorkData.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/08/09.
//

import Foundation

struct WorkList:Codable{
    var page:Int
    var totalPages:Int
    var totalResults:Int
    var results:[WorkListResponse]
    
    enum CodingKeys:String,CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case results
    }
}
