//
//  DeleteReview.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/09/12.
//

import Foundation

struct DeleteReview:Codable{
    var status:Int
    var data:Int?   //반환겂아 존혀 없지만 항상 null이 들어오기 떄문에 임의로 자료형 설정
    var message:String
}
