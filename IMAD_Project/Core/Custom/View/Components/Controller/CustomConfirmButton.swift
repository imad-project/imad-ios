//
//  CustomNextButton.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/08.
//

import SwiftUI

struct CustomConfirmButton: View {
   
    let text:String
    let color:Color
    let textColor:Color
    var action:()->()
    var body: some View {
        Button {
            action()
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 50)
                .foregroundColor(color)
                .overlay {
                    Text(text)
                        .font(.GmarketSansTTFMedium(15))
                        .foregroundColor(textColor)
                        .shadow(radius: 20)
                }
        }
    }
}

struct CustomConfirmButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomConfirmButton(text: "다음", color: .customIndigo.opacity(0.5), textColor: .white,action: {})
    }
}
