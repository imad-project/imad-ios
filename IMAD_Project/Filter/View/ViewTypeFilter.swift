//
//  ViewTypeFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 11/18/24.
//

import Foundation

enum ViewTypeFilter:Hashable{
    case workViewC(contentsId:Int)
    case workViewI(id:Int,type:String)
    case allRankingView(category:RankingCategory)
    case recommendListView(filter:RecommendFilter,contentsId:Int? = nil)
    case reviewDetailsView(goWork:Bool,reviewId:Int)
    case createReviewView(id:Int,image:String,workName:String,gradeAvg:Double,reviewId:Int,title:String,text:String,spoiler:Bool,rating:Double)
    case reviewView(id:Int)
}
