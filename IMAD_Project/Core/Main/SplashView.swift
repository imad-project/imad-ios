//
//  SplashView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/03.
//

import SwiftUI

struct SplashView: View {
    
    @State var logo = false
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            Color.gray.opacity(0.1).ignoresSafeArea()
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
            .offset(x:-20)
            .opacity(logo ? 1.0:0.0)
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                withAnimation(.easeIn(duration: 0.5)) {
                    logo = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
