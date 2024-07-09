//
//  Font.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/9/24.
//

import Foundation
import SwiftUI

extension Font {
    static func GmarketSansTTFBold(_ size: CGFloat) -> Font {
        return .custom("GmarketSansTTFBold", size: size)
    }
    static func GmarketSansTTFMedium(_ size: CGFloat) -> Font {
        return .custom("GmarketSansTTFMedium", size: size)
    }
    static func GmarketSansTTFLight(_ size: CGFloat) -> Font {
        return .custom("GmarketSansTTFLight", size: size)
    }
}
