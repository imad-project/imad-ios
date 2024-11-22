//
//  RecommendCache.swift
//  IMAD_Project
//
//  Created by 유영웅 on 10/31/24.
//

import Foundation

struct RecommendCache{
    var id:String
    var maxPage:Int
    var currentPage:Int
    var list:[RecommendResponse]
    
    init(id:String = "",maxPage:Int = 1,currentPage:Int = 1,list:[RecommendResponse] = []){
        self.id = id
        self.maxPage = maxPage
        self.currentPage = currentPage
        self.list = list
    }
}
