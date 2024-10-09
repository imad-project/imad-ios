//
//  SplashView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/03.
//

import SwiftUI

struct SplashView: View {
    
    @Binding var off:Bool
    
    @ViewBuilder
    var body: some View {
        ZStack{
            if off{
                Logo()
                    .offset(x:-20)
                    .opacity(off ? 1.0:0.0)
            }
        }
        .background(Color.white1)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeOut(duration: 1.5)){
                    off = false
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(off: .constant(true))
    }
}
