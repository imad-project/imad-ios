//
//  ReviewInfo.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/09/12.
//

import Foundation


struct ReadReview:Codable{
    var status:Int
    var data:ReadReviewResponse?
    var message:String
}

