//
//  ScoreView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/06.
//

import SwiftUI

struct ScoreView: View {
    
    @State var animaition = false
    @State var spacing:CGFloat = 0
    let score:CGFloat
    let color:Color
    let font:Font
    let widthHeight:CGFloat
    
    
    var body: some View {
        Circle()
            .trim(from: 0.0, to: animaition ? score * 0.1 : 0)
            .stroke(lineWidth: 3)
            .rotation(Angle(degrees: 270))
            .frame(width: widthHeight,height: widthHeight)
            .overlay{
                VStack(spacing:spacing){
                    Image(systemName: "star.fill")
                    Text(String(format: "%0.1f",score))
                }
                .font(font)
            }
            .foregroundColor(color)
            .background(Circle().stroke(lineWidth:0.5).foregroundColor(.black.opacity(0.7)))
            .onAppear{
                withAnimation(.linear(duration: 0.5)){
                    animaition = true
                }
                switch font{
                case .caption:
                    return spacing = 0
                default:
                    return spacing = 5
                }
               
            }
    }
       
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(score: 5.7, color: .white,font: .headline,widthHeight: 70)
            .background(Color.black)
    }
}
