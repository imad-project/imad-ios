//
//  AgeFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/17.
//

import Foundation
import SwiftUI

enum ProfileImageColorCategory:String, CaseIterable{
    case none
    case indigo
    case yellow
    case green
    case pink
    case blue
    case red
    var num:Int{
        switch self{
        case .none:
            return 0
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
    var color:Color{
        switch self{
        case .none:
            return .clear
        case .indigo:
            return .customIndigo
        case .yellow:
            return .orange
        case .green:
            return .green
        case .pink:
            return .purple
        case .blue:
            return .mint
        case .red:
            return .red
        }
    }
}
