//
//  CommunityDataResponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/14.
//

import Foundation

struct CommunityDataResponse:Codable{
    var postingId:Int
    
    enum CodaingKeys:String,CodingKey{
        case postingId = "posting_id"
    }
}
