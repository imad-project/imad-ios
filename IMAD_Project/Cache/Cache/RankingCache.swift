//
//  RankingCache.swift
//  IMAD_Project
//
//  Created by 유영웅 on 9/23/24.
//

import Foundation

struct RankingCache{
    var id:String
    var rankingType:RankingCategory
    var mediaType:TypeFilter
    var maxPage:Int
    var currentPage:Int
    var list:[RankingResponse]
}
