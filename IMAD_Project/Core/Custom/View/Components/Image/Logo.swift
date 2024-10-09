//
//  LogoView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 10/9/24.
//

import Foundation
import SwiftUI

struct Logo:View{
    var body:some View{
        ZStack{
            LinearGradient(colors: [Color.customIndigo,Color(cgColor: CGColor(red: 62/255, green: 88/255, blue: 112/255, alpha: 1))], startPoint: .leading, endPoint: .trailing)
                .frame(width:200)
            .mask{
                VStack(spacing:7.5){
                    Text("IMAD")
                        .bold()
                        .font(.GmarketSansTTFBold(40))
                    Rectangle()
                        .frame(width:150,height:3)
                        .offset(x:10)
                }
            }
            Image("indigo")
                .resizable()
                .scaledToFill()
                .frame(width: 80,height: 80)
                .offset(x:100,y:-3)
            
        }
    }
}
