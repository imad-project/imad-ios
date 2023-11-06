//
//  ScoreView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/06.
//

import SwiftUI

struct ScoreView: View {
    
    @State var animaition = false
    let score:CGFloat
    
    var body: some View {
        Circle()
            .trim(from: 0.0, to: animaition ? score * 0.1 : 0)
            .stroke(lineWidth: 3)
            .rotation(Angle(degrees: 270))
            .frame(width: 70,height: 70)
            .overlay{
                VStack(spacing:5){
                    Image(systemName: "star.fill")
                    Text(String(format: "%0.1f",score))
                }
                .font(.subheadline)
            }
            .foregroundColor(.white)
            .background(Circle().stroke(lineWidth:0.5).foregroundColor(.black.opacity(0.7)))
            .onAppear{
                withAnimation(.linear(duration: 0.5)){
                    animaition = true
                }
            }
    }
       
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(score: 5.7)
            .background(Color.black)
    }
}
