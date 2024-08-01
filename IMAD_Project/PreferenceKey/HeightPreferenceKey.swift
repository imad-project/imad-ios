//
//  HeightPreferenceKey.swift
//  IMAD_Project
//
//  Created by 유영웅 on 8/1/24.
//

import Foundation
import SwiftUI

struct HeightPreferenceKey: PreferenceKey {
    static func reduce(value _: inout CGFloat, nextValue _: () -> CGFloat) {}
    static var defaultValue: CGFloat = 0
}
