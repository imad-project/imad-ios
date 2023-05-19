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
           // BackgroundView(height: 0.33, height1: 0.37,height2: 0.35,height3: 0.36)
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
            Image("fish")
                .resizable()
                .frame(width: 100,height: 70)
                .frame(maxWidth: .infinity,alignment: .trailing)
                .frame(maxHeight: .infinity,alignment: .bottom)
                .padding(50)
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
