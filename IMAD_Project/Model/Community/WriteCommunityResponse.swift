//
//  CommunityDataResponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/14.
//

import Foundation

struct WriteCommunityResponse:Codable{
    let postingID: Int

    enum CodingKeys: String, CodingKey {
        case postingID = "posting_id"
    }
}
