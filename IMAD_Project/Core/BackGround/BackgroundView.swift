//
//  BackgroundView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/12.
//

import SwiftUI

struct BackgroundView: View {
    @State var phase:CGFloat = 0.0
    @State var phase1:CGFloat = 0.0
    let height:CGFloat
    let height1:CGFloat
    let height2:CGFloat
    let height3:CGFloat
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            Wave(reverse: true, progress: height, addX: 0.2, phase: phase).fill(LinearGradient(colors: [Color.customIndigo.opacity(0.3),Color.customIndigo], startPoint: .top, endPoint: .bottom))
                .onAppear{
                    withAnimation(.linear(duration: 3).repeatForever(autoreverses:false)){
                        self.phase = .pi * 2
                    }
                }
                .ignoresSafeArea()
            Wave(reverse: true, progress: height1, addX: 0.4, phase: phase).fill(Color.customIndigo.opacity(0.3))
                .onAppear{
                    withAnimation(.linear(duration: 3).repeatForever(autoreverses:false)){
                        self.phase = .pi * 2
                    }
                }
                .ignoresSafeArea()
            Wave(reverse: false, progress: height2, addX: 0.4, phase: phase).fill(Color.customIndigo.opacity(0.3))
                .onAppear{
                    withAnimation(.linear(duration: 3).repeatForever(autoreverses:false)){
                        self.phase = .pi * 2
                    }
                }
                .ignoresSafeArea()
            Wave(reverse: false, progress: height3, addX: 0.5, phase: phase).fill(Color.customIndigo.opacity(0.3))
                .shadow(radius: 20)
                .onAppear{
                    withAnimation(.linear(duration: 3).repeatForever(autoreverses:false)){
                        self.phase1 = .pi * 2
                    }
                }
                .ignoresSafeArea()
        }
    }
    
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(height: 0.83, height1: 0.87,height2: 0.85,height3: 0.86)
    }
}
