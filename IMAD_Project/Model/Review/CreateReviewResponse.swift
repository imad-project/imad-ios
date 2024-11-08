//
//  WriteReviewResponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/07.
//

import Foundation

struct CreateReviewResponse:Codable,Hashable{
    var id:Int
    enum CodingKeys:String, CodingKey{
        case id = "review_id"
    }
}
