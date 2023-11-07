//
//  Review.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/14.
//

import Foundation

struct WriteReview:Codable,Hashable{
    var status:Int
    var data:WriteReviewResponse?
    var message:String
}

