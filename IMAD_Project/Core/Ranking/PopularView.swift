//
//  PopularView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 3/12/24.
//

import SwiftUI


struct PopularView: View {
    var review:PopularReviewResponse?
    var posting:PopularPostingResponse?
    
    var popular:Popular{
        if let review{
            return PopularReviewClass(review: review)
        }else{
            return PopularPostingClass(posting: posting!)
        }
    }
    var today:String{
        if review != nil{
            return "🏅 오늘의 리뷰"
        }else{
            return "🏅 오늘의 게시물"
        }
    }
    var body: some View {
        VStack(alignment: .leading){
            Text(today).bold()
            HStack(alignment:.bottom,spacing: 0){
                if review != nil{
                    KFImageView(image: popular.poster().getImadImage())
                        .frame(width: UIScreen.main.bounds.width/3)
                }
                HStack{
                    VStack(alignment:.leading){
                        HStack{
                            VStack(alignment:.leading){
                                Text(popular.contentsTitle())
                                    .bold()
                                    .font(.title3)
                                    .foregroundColor(.customIndigo.opacity(0.8))
                                Text(popular.title()).fontWeight(.black)
                                    
                            }
                            Spacer()
                            VStack{
                                ProfileImageView(imageCode: popular.userProfile(), widthHeigt: 30)
                                Text(popular.userName())
                                    .font(.caption2)
                            }
                        }
                        .padding(.bottom)
                        Text(popular.contents())
                        Spacer()
                    }
                    Spacer()
                }
                .padding(5)
                Spacer()
                if review == nil{
                    KFImageView(image: popular.poster().getImadImage())
                        .frame(width: UIScreen.main.bounds.width/3)
                }
            }
            .background(Color.white)
            .frame(height: UIScreen.main.bounds.height/4)
            .cornerRadius(30)
        }
        
    }
}

#Preview {
    ZStack{
        Color.black.opacity(0.5).ignoresSafeArea()
        PopularView(review: CustomData.instance.popularReview)
    }
}
