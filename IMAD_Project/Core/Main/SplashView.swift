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
            VStack{
                Image("logoName")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200,height: 100)
                    .opacity(logo ? 1.0:0.0)
                Text("아이매드")
                    .bold()
                    .foregroundColor(.customIndigo)
                    .opacity(logo ? 1.0:0.0)
            }
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
