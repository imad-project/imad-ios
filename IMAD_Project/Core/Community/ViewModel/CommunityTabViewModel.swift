//
//  CommunityTabViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/06.
//

import Foundation

class CommunityTabViewModel:ObservableObject{
    
 
    @Published var communityTab:CommunityFilter = .all
  
    
    func indicatorOffset(width:CGFloat)->CGFloat{
        let index = CGFloat(getIndex())
        if index == 0{return 0}
        let buttonWidth = width/CGFloat(CommunityFilter.allCases.count)
        
        return index * buttonWidth
        
    }
    func getIndex() ->Int{
        switch communityTab{
        case .all:
            return 0
        case .free:
            return 1
        case .question:
            return 2
        case .debate:
            return 3
        }
    }
}
