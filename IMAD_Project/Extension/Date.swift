//
//  Date.swift
//  IMAD_Project
//
//  Created by 유영웅 on 9/19/24.
//

import Foundation

extension Date{
    func timeDifference(previousTime:Date?,curruntTime:Date)->Double{
        
        guard let previousTime else {return 0}
        return curruntTime.timeIntervalSince(previousTime)
    }
}
