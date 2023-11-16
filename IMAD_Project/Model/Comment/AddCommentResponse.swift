//
//  AddCommetResponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/10.
//

import Foundation

struct AddCommentIdResponse:Codable{
    var commentId:Int
    enum CodingKeys:String,CodingKey{
        case commentId = "comment_id"
    }
}
