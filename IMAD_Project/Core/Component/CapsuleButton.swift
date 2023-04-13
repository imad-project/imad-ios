//
//  CapsuleButton.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/13.
//

import SwiftUI

struct CapsuleButton: View {
    let bottonColor:Color
    let title:any View
    let titleColor:Color?
    let action:()
    
    var body: some View {
        Button {
            action
        } label: {
            Capsule()
                .frame(height: 50)
                .overlay{
                    title
                        //.bold()
//                        .foregroundColor(titleColor)
//                        .shadow(radius: 20)
                }
        } .frame(maxWidth: .infinity)
    }
}

struct CapsuleButton_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleButton(bottonColor: .red, title: Text("버튼"), titleColor: .customIndigo, action: ())
    }
}
