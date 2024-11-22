//
//  ReviewCache.swift
//  IMAD_Project
//
//  Created by 유영웅 on 11/21/24.
//

import Foundation

struct ReviewCache{
    var id:Int
    var maxPage:Int
    var currentPage:Int
    var list:[ReviewResponse]
    
    init(id:Int = 0,maxPage:Int = 1,currentPage:Int = 1,list:[ReviewResponse] = []){
        self.id = id
        self.maxPage = maxPage
        self.currentPage = currentPage
        self.list = list
    }
}
