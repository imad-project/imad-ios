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
        VStack{
            if let popular{
                KFImageView(image:popular.poster().getImadImage())
                    .overlay {
                        Color.clear
                            .background(Material.thin)
                        HStack{
                            VStack(alignment: .leading){
                                HStack{
                                    Text(popular.contentsTitle())
                                        .lineLimit(1)
                                        .font(.subheadline)
                                        .fontWeight(.black)
                                        .foregroundColor(.customIndigo)
                                    Text(popular.spoiler() ? "스포일러" : "클린")
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .padding(2)
                                    .bold()
                                    .font(.caption2)
                                    .background(Color.customIndigo)
                                    .cornerRadius(10)
                                }
                                Text("#" + today)
                                    .foregroundColor(.black.opacity(0.8))
                                    .font(.caption2)
                                Text(popular.title())
                                    .font(.footnote)
                                    .lineLimit(1)
                                    .foregroundColor(.black)
                            }
                            .padding(.trailing,20)
                            HStack(spacing:0){
                                KFImageView(image: popular.poster().getImadImage(),width: 70,height: 100)
                                KFImageView(image: popular.poster().getImadImage(),width: 70,height: 100)
                                    .rotationEffect(Angle(degrees: 20))
                            }
                        }
                        .padding(.leading,20)
                        VStack(spacing: 0){
                            ProfileImageView(imageCode: popular.userProfile(), widthHeigt: 30)
                            Text(popular.userName())
                                .font(.caption2)
                                .foregroundColor(.white)
                                .shadow(color:.black,radius: 1)
                        }
                        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topTrailing)
                        .padding(20)
                        
                    }
                    .frame(width: UIScreen.main.bounds.width-30,height: 80)
                    .cornerRadius(5)
            }
        }
    }
}

#Preview {
    ZStack{
        Color.black.opacity(0.5).ignoresSafeArea()
        PopularView(review: CustomData.instance.popularReview)
    }
}
