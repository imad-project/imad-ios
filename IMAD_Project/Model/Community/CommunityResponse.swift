//
//  CommunityResponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/14.
//

import Foundation

struct CommunityResponse:Codable{
    let status:Int
    var data:CommunityDataResponse?
    let message:Bool
}


