//
//  StageTabViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/13.
//

import Foundation

class StageTabViewModel:ObservableObject{
    
    @Published var tab:RegisterFilter = .info
  
    func indicatorOffset(width:CGFloat)->CGFloat{
        let index = CGFloat(getIndex())
        if index == 0{return 0}
        let buttonWidth = width/CGFloat(Tab.allCases.count) + 30
        
        return index * buttonWidth
        
    }
    
    func getIndex() ->Int{
        switch tab{
        case .info:
            return 0
        case .genre:
            return 1
        case .photo:
            return 2
        }
    }
}
