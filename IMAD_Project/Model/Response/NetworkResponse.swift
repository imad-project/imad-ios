//
//  NetworkResponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 10/31/24.
//

import Foundation

struct NetworkResponse<Model:Codable>:Codable{
    let status:Int
    let data:Model?
    let message:String
}
