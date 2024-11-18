//
//  NavigationViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 11/14/24.
//

import Foundation
import SwiftUI

enum ViewType:Hashable{
    case workViewC(contentsId:Int)
    case workViewI(id:Int,type:String)
    case allRankingView(category:RankingCategory)
    case recommendListView(filter:RecommendFilter,contentsId:Int? = nil)
}
class ViewManager:ObservableObject{
    static let instance = ViewManager()
    @Published var path:[ViewType] = []
    private init(){}
    func root(){
        path.removeAll()
    }
    func back(){
        path.removeLast()
    }
    func move(type:ViewType){
        path.append(type)
    }
    func view(type:ViewType) -> some View{
        return Group{
            switch type {
            case let .workViewC(contentsId):
                WorkView(contentsId:contentsId)
            case let .workViewI(id,type):
                WorkView(id:id,type:type)
            case .allRankingView(let category):
                AllRankingView(filter:category)
            case .recommendListView(let filter, let contentsId):
                AllRecommendView(contentsId:contentsId,type:filter)
            }
        }
        .navigationBarBackButtonHidden()
    }
    
}
