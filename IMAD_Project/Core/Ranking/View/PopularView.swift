//
//  PopularView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 3/12/24.
//

import SwiftUI
import Kingfisher

struct PopularView: View {
    var review:PopularReviewResponse?
    var posting:PopularPostingResponse?
    
    var popular:Popular?{
        var popular:Popular?
        if let review{
            popular = PopularReviewClass(review: review)
        }else if let posting{
            popular  = PopularPostingClass(posting: posting)
        }
        return popular
    }
    var today:String{
        if review != nil{
            return "오늘의 리뷰"
        }else{
            return "오늘의 게시물"
        }
    }
    var body: some View {
        ZStack{
            if let popular{
                KFImageView(image:popular.backdrop().getImadImage())
                Color.clear
                    .background(Material.thin)
                HStack(alignment: .top){
                    VStack{
                        ProfileImageView(imagePath: popular.userProfile(), widthHeigt: 20)
                           Text(popular.userName())
                                .font(.caption2)
                               .foregroundColor(.black)
                    }
                    VStack(alignment: .leading){
                        HStack{
                            Text(popular.contentsTitle())
                                .lineLimit(1)
                                .font(.GmarketSansTTFMedium(15))
                                .fontWeight(.black)
                                .foregroundColor(.customIndigo)
                            if popular.spoiler(){
                                Text("스포")
                                    .padding(.horizontal)
                                    .padding(2)
                                    .bold()
                                    .font(.caption2)
                                    .background(Capsule().stroke(lineWidth: 2))
                                    .cornerRadius(10)
                                    .foregroundColor(.customIndigo)
                            }
                            Spacer()
                        }
                        .frame(width:270,alignment: .leading)
                        Text("#" + today)
                            .foregroundColor(.black.opacity(0.8))
                            .font(.caption2)
                        Text(popular.title())
                            .font(.GmarketSansTTFMedium(12))
                            .lineLimit(1)
                            .foregroundColor(.black)
                            .frame(width:250,alignment: .leading)
                    }
                    Spacer()
                    
                }
                .padding(.leading)
                .overlay(alignment:.trailing){
                    KFImageView(image: popular.poster().getImadImage(),width: 70,height: 100)
                        .cornerRadius(5)
                        .rotationEffect(Angle(degrees: 20))
                }
            }
        } 
        .frame(height: 80)
        .cornerRadius(5)
        .padding(.leading,10)

    }
}

#Preview {
    ZStack{
        Color.black.opacity(0.5).ignoresSafeArea()
        PopularView(review: CustomData.instance.popularReview)
    }
}
