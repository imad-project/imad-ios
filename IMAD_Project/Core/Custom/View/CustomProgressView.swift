//
//  CustomProgressView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/06/04.
//

import SwiftUI

struct CustomProgressView: View {
    @State private var rotation = 0.0
    @State var num = 0
    let dot = [".",".."]
    
    var body: some View {
        VStack(spacing:20){
            Circle()
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [Color.white, Color.customIndigo]),
                        center: .center,
                        startAngle: .zero,
                        endAngle: .degrees(360)
                    ),
                    lineWidth: 10
                )
                .frame(width: 50, height: 50)
                .rotationEffect(Angle(degrees: rotation))
            HStack{
                Text("잠시만 기다려주세요")
                    .foregroundColor(.black)
            }
            
        }.background{
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 200,height: 250)
                .foregroundColor(.white)
                .shadow(radius: 20)
        }
        
        .onAppear {
            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                rotation = 360
            }
            withAnimation(Animation.default.repeatForever()) {
                num += 1
            }
        }
    }
}

struct CustomProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressView()
    }
}
