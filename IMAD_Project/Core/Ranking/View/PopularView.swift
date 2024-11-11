//
//  PopularView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 3/12/24.
//

import SwiftUI
import Kingfisher

struct PopularView: View {
    var popular:Popular
    
    var body: some View {
        HStack{
            VStack(alignment: .leading,spacing:isPad ? 15 : 10){
                headerView(popular)
                contentsView(popular)
            }
            KFImageView(image: popular.poster.getImadImage(),width: frame.height - 40)
                .cornerRadius(5)
        }
        .padding(10)
        .frame(frame)
        .background(.gray.opacity(0.2))
        .cornerRadius(10)
        .foregroundColor(.black)
    }
}

extension PopularView{
    var frame: CGSize {
        let width:CGFloat = mainWidth < 400 ? mainWidth - 35 : mainWidth/1.5 - 15
        let height:CGFloat = isPad ? 150 : 100
        return CGSize(width: width, height: height)
    }
    func headerView(_ popular:Popular)->some View{
        HStack{
            ProfileImageView(imagePath: popular.userProfile, widthHeigt:isPad ? 30 : 18)
            Text(popular.userName)
                .font(.GmarketSansTTFMedium(isPad ? 18 : 12))
            Spacer()
            if popular.spoiler{
                Text("스포일러")
                    .font(.GmarketSansTTFMedium(isPad ? 12 : 7.5))
                    .padding(isPad ? 5 : 2.5)
                    .padding(.horizontal,3)
                    .background(Capsule().stroke(lineWidth: 1))
            }
        }
    }
    func contentsView(_ popular:Popular)->some View{
        VStack(alignment: .leading,spacing:isPad ? 15 : 10){
            if !popular.spoiler{
                Text(popular.title)
                    .font(.GmarketSansTTFMedium(isPad ? 25 : 17.5))
            }
            Spacer()
            Text(popular.contentsTitle)
                .font(.GmarketSansTTFMedium(isPad ? 20 : 12.5))
                .opacity(0.7)
        }
    }
}

#Preview {
    return HStack(spacing: 10){
        PopularView(popular:PopularResponse(review:CustomData.review))
            .background(Color.white.frame(width: 1000, height:1000))
    }
}
