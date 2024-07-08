//
//  Int.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/08.
//

import Foundation

extension Int{
    //MARK: 숫자 소수점 만들고 문자열로 반환
    func commaNumber() -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: self))!
    }
    func getImageValue()->String{
        return "default_profile_image_\(self).png"
    }
}
