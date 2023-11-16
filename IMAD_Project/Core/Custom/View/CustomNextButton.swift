//
//  CustomNextButton.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/08.
//

import SwiftUI

struct CustomNextButton: View {
    let action:()->()
    let color:Color
    var body: some View {
        Button {
            action()
//            withAnimation(.linear){
//                action
//            }
        } label: {
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 60)
                .foregroundColor(color)
                .overlay {
                    Text("다음")
                        .bold()
                        .foregroundColor(.white)
                        .shadow(radius: 20)
                }
        }.padding(.horizontal)
            .padding(.bottom,50)
    }
}

struct CustomNextButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomNextButton(action: {},color: .customIndigo.opacity(0.5))
    }
}
