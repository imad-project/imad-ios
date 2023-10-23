//
//  CommentReadResponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/23.
//

import Foundation

struct CommentReadResponse:Codable{
    let status:Int
    var data:CommentResponse?
    let message:String
}
