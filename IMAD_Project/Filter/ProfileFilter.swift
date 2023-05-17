//
//  AgeFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/17.
//

import Foundation

enum ProfileFilter:String, CaseIterable{
    case masic
    case korean
    case happy
    case beach
    case grape
    case noel
    case none
    
    var num:Int{
        switch self{
        case .none:
            return 0
        case .masic:
            return 1
        case .korean:
            return 2
        case .happy:
            return 3
        case .beach:
            return 4
        case .grape:
            return 5
        case .noel:
            return 6

        }
    }
    
}
