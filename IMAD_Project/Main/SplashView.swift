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
            logo ? Color.customIndigo.ignoresSafeArea() :
            Color.white.ignoresSafeArea()
            Image("logoName")
                .resizable()
                .scaledToFill()
                .frame(width: logo ? 5000: 200,height: 100)
                .opacity(logo ? 0:1.0)
            
        }.onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
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
