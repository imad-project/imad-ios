//
//  Int.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/08.
//

import Foundation

extension Int{
    func getImageValue()->String{
        return "default_profile_image_\(self).png"
    }
    var currentDate:Int{
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return components.year!
    }
}
