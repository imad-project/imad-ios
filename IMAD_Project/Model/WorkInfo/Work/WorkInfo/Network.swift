//
//  Network.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/08/21.
//

import Foundation

struct Network:Identifiable,Codable,Hashable{
    let id: Int
    let logoPath, name, originCountry: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}
