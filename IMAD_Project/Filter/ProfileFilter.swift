//
//  AgeFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/17.
//

import Foundation

enum ProfileFilter:String, CaseIterable{
    case happy
    case ohmygod
    case soso
    case angry
    case kidding
    case hate
    case none
    
    var num:Int{
        switch self{
        case .none:
            return -1
        case .happy:
            return 1
        case .ohmygod:
            return 2
        case .soso:
            return 3
        case .angry:
            return 4
        case .kidding:
            return 5
        case .hate:
            return 6

        }
    }
    var name:String{
        switch self{
        case .none:
            return ""
        case .happy:
            return "행복이"
        case .ohmygod:
            return "놀래미"
        case .soso:
            return "침착이"
        case .angry:
            return "짜증이"
        case .kidding:
            return "장난이"
        case .hate:
            return "극혐이"

        }
    }
    
}
