//
//  NavigationViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 11/14/24.
//

import Foundation
import SwiftUI

struct WorkViewType:Hashable{
    var contentsId:Int?
    var workId:Int?
    var type:String?
}

class ViewManager:ObservableObject{
    static let instance = ViewManager()
    @Published var path:[WorkViewType] = []
    private init(){}
    func root(){
        path.removeAll()
    }
    func move(contentsId:Int? = nil,id:Int? = nil,type:String? = nil){
        path.append(WorkViewType(contentsId: contentsId,workId:id,type:type))
    }
    func workView(contentsId:Int? = nil,id:Int? = nil,type:String? = nil) -> some View{
        WorkView(id:id, type:type, contentsId: contentsId)
            .navigationBarBackButtonHidden()
    }
}
