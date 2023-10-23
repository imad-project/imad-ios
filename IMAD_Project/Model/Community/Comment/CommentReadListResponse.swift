//
//  CommentReadListResponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/23.
//

import Foundation

struct CommentReadListResponse:Codable{
    let status:Int
    var data:CommentListReponse?
    let message:String
}
