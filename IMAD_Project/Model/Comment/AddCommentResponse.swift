//
//  AddCommentResponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/19.
//

import Foundation

struct AddCommentResponse:Codable{
    let status:Int
    var data:CommentIdResponse
    let message:String
}
struct CommentIdResponse:Codable{
    var commentId:Int
    
    enum CodingKeys:String,CodingKey{
        case commentId = "comment_id"
    }
}
