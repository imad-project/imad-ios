//
//  NavigationViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 11/14/24.
//

import Foundation
import SwiftUI


class ViewManager:ObservableObject{
    static let instance = ViewManager()
    @Published var path:[ViewTypeFilter] = []
    private init(){}
    func root(){
        path.removeAll()
    }
    func back(){
        path.removeLast()
    }
    func move(type:ViewTypeFilter){
        path.append(type)
    }
    func view(type:ViewTypeFilter) -> some View{
        return Group{
            switch type {
            case let .workViewC(contentsId):
                WorkView(contentsId:contentsId)
            case let .workViewI(id,type):
                WorkView(id:id,type:type)
            case let .allRankingView(category):
                AllRankingView(filter:category)
            case let .recommendListView(filter,contentsId):
                AllRecommendView(contentsId:contentsId,type:filter)
            }
        }
        .navigationBarBackButtonHidden()
    }
    
}
