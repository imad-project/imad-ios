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
            return "캘리"
        case .ohmygod:
            return "수잔"
        case .soso:
            return "리사"
        case .angry:
            return "소피아"
        case .kidding:
            return "스티브"
        case .hate:
            return "프랭크"

        }
    }
    
}
