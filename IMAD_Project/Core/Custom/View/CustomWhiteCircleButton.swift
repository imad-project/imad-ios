//
//  CustomWhiteCircleButton.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/08.
//

import Foundation
import SwiftUI

struct CustomWhiteCirecleButtom:ViewModifier{
    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .padding(5)
            .bold()
            .font(.caption)
            .background(Capsule().foregroundColor(.white))
            .shadow(radius: 20)
    }
}
