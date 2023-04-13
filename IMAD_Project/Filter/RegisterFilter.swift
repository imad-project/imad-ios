//
//  RegisterFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/13.
//

import Foundation

enum RegisterFilter:CaseIterable{
    case info
    case genre
    case photo
    
    var image:String{
        switch self{
        case .info:
            return "1.circle.fill"
        case .genre:
            return "2.circle.fill"
        case .photo:
            return "3.circle.fill"
        }
    }
}
