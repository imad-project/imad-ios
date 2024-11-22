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
    var mediaType:WorkTypeCategory
    var maxPage:Int
    var currentPage:Int
    var list:[RankingResponse]
    
    init(id:String = "",rankingType:RankingCategory = .all,mediaType:WorkTypeCategory = .all,maxPage:Int = 1,currentPage:Int = 1,list:[RankingResponse] = []) {
        self.id = id
        self.rankingType = rankingType
        self.mediaType = mediaType
        self.maxPage = maxPage
        self.currentPage = currentPage
        self.list = list
    }
}
