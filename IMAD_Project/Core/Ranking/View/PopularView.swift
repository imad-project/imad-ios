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
            return "🏅리뷰"
        }else{
            return "🎖️게시물"
        }
    }
    var body: some View {
        VStack{
            if let popular{
                VStack{
                    KFImageView(image: popular.poster().getImadImage())
                        .frame(height: 200)
                        .overlay{
                            Color.black.opacity(0.5)
                            VStack{
                                Text(today).bold().frame(maxWidth: .infinity,alignment: .leading)
                                    .foregroundColor(.white)
                                Spacer()
                                HStack{
                                    Text(popular.contentsTitle())
                                        .lineLimit(1)
                                        .bold()
                                        .font(.title3)
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                                HStack{
                                    ProfileImageView(imageCode: popular.userProfile(), widthHeigt: 20)
                                    Text(popular.userName()).font(.subheadline)
                                        .foregroundStyle(.white)
                                    Spacer()
                                }
                            }
                            .padding()
                        }
                    HStack{
                        VStack(alignment: .leading){
                            
                            Text(popular.title())
                                .font(.body)
                                .bold()
                            Text(popular.contents())
                                .font(.subheadline)
                            Spacer()
                        }
                        .foregroundColor(.black)
                        Spacer()
                    }
                    .lineLimit(1)
                    .padding(10)
                    
                    
                }
                .background(Color.white)
                .cornerRadius(10)
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
