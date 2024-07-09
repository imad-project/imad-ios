//
//  Font.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/9/24.
//

import Foundation
import SwiftUI

extension Font{
    func GmarketSansTTFBold(_ size :CGFloat)-> Font{
        return .custom("GmarketSansTTFBold", size: size)
    }
    func GmarketSansTTFMedium(_ size :CGFloat)-> Font{
        return .custom("GmarketSansTTFMedium", size: size)
    }
    func GmarketSansTTFLight(_ size :CGFloat)-> Font{
        return .custom("GmarketSansTTFLight", size: size)
    }
}
