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
        VStack(alignment: .leading,spacing: 45){
            Spacer()
            titleView
            descriptView
            Spacer()
            imageView
            Spacer()
        }
        .padding(.horizontal,20)
        .foregroundColor(.white)
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView(title: "커뮤니티", descrpit: "재밌게 본 드라마나 영화에 대해 마음껏 본인의 생각을 펼쳐보세요!", image: "ghost", height: 200)
            .background(Color.customIndigo)
    }
}

extension OnBoardingView{
    var titleView:some View{
        Text(title)
            .bold()
            .font(.GmarketSansTTFMedium(35))
    }
    var descriptView:some View{
        Text(descrpit)
            .font(.GmarketSansTTFMedium(18))
    }
    var imageView:some View{
        HStack{
            Spacer()
            Image(image)
                .resizable()
                .frame(width: 300,height: height)
                .padding()
            
        }.offset(y:70)
    }
}
