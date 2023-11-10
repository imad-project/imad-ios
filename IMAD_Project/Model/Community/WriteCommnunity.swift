//
//  CommunityResponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/14.
//

import Foundation

struct WriteCommnunity:Codable{
    let status:Int
    var data:WriteCommunityResponse?
    let message:String
}


