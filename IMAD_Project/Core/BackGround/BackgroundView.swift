//
//  BackgroundView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/12.
//

import SwiftUI

struct BackgroundView: View {
    @State var phase:CGFloat = 0.0
    let height:CGFloat
    let height1:CGFloat
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            Color.white.ignoresSafeArea()
            Wave(progress: height, phase: phase).fill(Color.customIndigo)
                .onAppear{
                    withAnimation(.linear(duration: 3).repeatForever(autoreverses:false)){
                        self.phase = .pi * 2
                    }
                }
                .ignoresSafeArea()
            Wave(progress: height1, phase:0).fill(Color.customIndigo.opacity(0.5))
                .shadow(radius: 20)
            
            Image("fish")
                .resizable()
                .frame(width: 100,height: 70)
                .padding(.bottom,100)
                .padding(.trailing,50)
                .shadow(radius: 20)
        }
    }
    
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(height: 0.83, height1: 0.9)
    }
}
