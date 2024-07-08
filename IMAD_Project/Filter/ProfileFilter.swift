//
//  AgeFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/17.
//

import Foundation

enum ProfileFilter:String, CaseIterable{
    case indigo
    case yellow
    case green
    case pink
    case blue
    case red
    
    var num:Int{
        switch self{
        case .indigo:
            return 1
        case .yellow:
            return 2
        case .green:
            return 3
        case .pink:
            return 4
        case .blue:
            return 5
        case .red:
            return 6

        }
    }
}
