//
//  RoundShape.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/11.
//

import Foundation
import SwiftUI

struct RoundedShape:Shape{
    var corners:UIRectCorner    //직사각형 모서리값
    var width:Double
    var height:Double
    
    func path(in rect: CGRect) -> Path{
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: width, height: height))
        //직사각형 코너와 사이즈등 규격 기재
        return Path(path.cgPath)
        //세팅된 직사각형 규격을 경로로 보내서 주문제작
    }
}



