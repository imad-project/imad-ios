//
//  OnBoardingReviewView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/26.
//

import SwiftUI

struct OnBoardingView: View {
    let title:String
    let descrpit:String
    let image:String
    let height:CGFloat
    var body: some View {
            VStack(alignment: .leading,spacing: 15){
                Spacer()
                Group{
                    Text(title)
                        .font(.largeTitle)
                        .padding(.bottom)
                    Text(descrpit)
                }
                .bold()
                .padding(.leading,30)
                Spacer()
                HStack{
                    Spacer()
                    Image(image)
                        .resizable()
                        .frame(width: 250,height: height)
                        .padding()
                    
                }.offset(y:70)
                Spacer()

            }
            .foregroundColor(.customIndigo)
            .background{
                Color.white.ignoresSafeArea()
                Color.gray.opacity(0.2).ignoresSafeArea()
            }
           
           
        
    }
}

struct OnBoardingReviewView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView(title: "커뮤니티", descrpit: "재밌게 본 드라마나 영화에 대해 마음껏 본인의 생각을 펼쳐보세요!", image: "review", height: 200)
    }
}
