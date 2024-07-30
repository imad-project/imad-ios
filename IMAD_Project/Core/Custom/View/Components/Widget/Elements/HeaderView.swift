//
//  HeaderView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/29/24.
//

import SwiftUI

struct HeaderView: View {
    var backIcon:String?
    let text:String
    var event:(()->())?
    var body: some View {
        HStack{
            if let backIcon,let event{
                Button {
                    event()
                } label: {
                    Image(systemName: backIcon)
                        .font(.GmarketSansTTFMedium(20))
                }
            }
            Text(text)
                
                .font(.GmarketSansTTFMedium(25))
            Spacer()
        }
        .bold()
        .foregroundColor(.black)
    }
}

#Preview {
    HeaderView(backIcon: "chevron.left", text: "커뮤니티"){
        print("ddasd")
    }
}
