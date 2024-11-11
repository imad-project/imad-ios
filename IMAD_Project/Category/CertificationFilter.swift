//
//  CertificationFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/08/18.
//

import Foundation
import SwiftUI

enum CertificationFilter:String,CaseIterable{
    
    case all = "All"
    case seven = "7"
    case twelve = "12"
    case fifteen = "15"
    case adult = "19"
    case screening = "Restricted Screening"
    case exempt = "Exempt"
    case none = "NONE"
    
    var color:Color{
        switch self{
        case .all:
            return Color.green
        case .seven:
            return Color.cyan
        case .twelve:
            return Color.yellow
        case .fifteen:
            return Color.blue
        case .adult:
            return Color.red
        case .screening:
            return Color.gray
        case .exempt:
            return Color.brown
        case .none:
            return Color.black
        }
    }
    
    var name:String{
        switch self{
        case .all:
            return "All"
        case .seven:
            return "7"
        case .twelve:
            return "12"
        case .fifteen:
            return "15"
        case .adult:
            return "19"
        case .screening:
            return "제한"
        case .exempt:
            return "면제"
        case .none:
            return "미상"
        }
    }
    
}
