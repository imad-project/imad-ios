//
//  PopularView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 3/12/24.
//

import SwiftUI
import Kingfisher

struct PopularView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass

       
    var review:PopularReviewResponse?
    var posting:PopularPostingResponse?
    
    var body: some View {
        ZStack{
            if let popular{
                    KFImageView(image:popular.backdrop().getImadImage())
                    Color.clear
                        .background(Material.thin)
                        .colorScheme(.dark)
                    VStack(alignment: .leading,spacing:isPad() ? 10 : 5){
                        Text(today)
                            .font(.GmarketSansTTFBold(isPad() ? 15 : 10))
                        Text(popular.title())
                            .font(.GmarketSansTTFMedium(isPad() ? 20 : 10))
                        if popular.spoiler(){
                            Text("스포")
                                .font(.GmarketSansTTFMedium(isPad() ? 12.5 : 7.5))
                                .padding(5)
                                .padding(.horizontal,3)
                                .background(Capsule().stroke(lineWidth: 1))
                        }
                        Spacer()
                        HStack(alignment: .bottom){
                            HStack{
                                KFImageView(image:popular.poster().getImadImage(),width: isPad() ? 50 : 30 ,height: isPad() ? 70 : 40)
                                    .cornerRadius(3)
                                Text(popular.contentsTitle())
                                    .font(.GmarketSansTTFMedium(isPad() ? 20 : 10))
                                    .opacity(0.7)
                            }
                            Spacer()
                            HStack{
                                ProfileImageView(imagePath: popular.userProfile(), widthHeigt:isPad() ? 30 : 25 )
                                Text(popular.userName())
                                    .font(.GmarketSansTTFMedium(isPad() ? 15 : 12))
                            }
                        }
                    }
                    .foregroundColor(.white)
                    .padding(isPad() ? 20 : 10)
            }
        }
        .frame(frame)
        .cornerRadius(10)
        
    }
}

extension PopularView{
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
        review != nil ? "오늘의 리뷰🥇" : "오늘의 게시물🥇"
    }
    var frame: CGSize {
        let width = mainWidth/2 - 15
        let height = isWidth() ? (isPad() ? mainHeight/3 : mainHeight/4) : mainHeight/6
        return CGSize(width: width, height: height)
    }
}

#Preview {
    HStack(spacing: 10){
        PopularView(review: CustomData.instance.popularReview)
        PopularView(review: CustomData.instance.popularReview)
    }
}
