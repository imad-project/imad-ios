//
//  AddCommentResponse.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/19.
//

import Foundation

struct AddComment:Codable{
    let status:Int
    var data:AddCommentIdResponse?
    let message:String
}

