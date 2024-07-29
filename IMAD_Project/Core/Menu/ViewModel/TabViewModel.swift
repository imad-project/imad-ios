//
//  TabViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/06.
//

import Foundation


class TabViewModel:ObservableObject{
    
    @Published var tab:TabFilter = .home
  
    
    func indicatorOffset(width:CGFloat)->CGFloat{
        let index = CGFloat(getIndex())
        if index == 0{return 0}
        let buttonWidth = width/CGFloat(TabFilter.allCases.count)
        
        return index * buttonWidth
        
    }
    func getIndex() ->Int{
        switch tab{
        case .home:
            return 0
        case .community:
            return 1
        case .notification:
            return 2
        case .profile:
            return 3
        }
    }
}
