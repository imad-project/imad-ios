//
//  ReviewListRowView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/09/15.
//

import SwiftUI
import Kingfisher

struct ReviewListRowView: View {
    let review:ReadReviewResponse
    let my:Bool
    
    var body: some View {
        VStack(alignment: .leading){
            profileAndDateView
            HStack{
                contentView
                Spacer()
                scoreAndLike
            }
            likeView
            if my{
                HStack{
                    KFImage(URL(string: review.contentsPosterPath.getImadImage()))
                        .resizable()
                        .frame(width: 30,height: 30)
                        .cornerRadius(5)
                    Text(review.contentsTitle)
                        .font(.GmarketSansTTFMedium(13))
                        .fontWeight(.medium)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .padding(.trailing)
                }
                .font(.subheadline)
                .foregroundColor(.black.opacity(0.7))
                .background(Color.white)
                .cornerRadius(5)
                .shadow(radius: 1)
            }
        }
        .padding(10)
        .background(Color.white)
    }
}

struct ReviewListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewListRowView(review: CustomData.instance.review, my: true)
    }
}
extension ReviewListRowView{
    var profileAndDateView:some View{
        HStack{
            ProfileImageView(imagePath: review.userProfileImage,widthHeigt: 25)
            Text(review.userNickname)
                .font(.subheadline)
                .bold()
            if review.spoiler{
                Capsule()
                .stroke(lineWidth: 1)
                .frame(width: 45, height: 18)
                .overlay {
                    Text("스포")
                        .font(.caption2)
                        .bold()
                }
                .foregroundColor(.customIndigo)
            }
            Spacer()
        }
        .padding(.bottom,5)
    }
    var contentView:some View{
        VStack(alignment: .leading,spacing:3) {
            Text(review.title)
                .font(.GmarketSansTTFMedium(17))
            HStack{
                Text(review.spoiler ? "스포일러가\n포함된 리뷰입니다." : review.content)
                    .font(.system(size: 16))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
        }
    }
    var scoreAndLike:some View{
        ScoreView(score: review.score, color: .customIndigo,font: .caption,widthHeight: 50)
    }
    var likeView:some View{
            HStack(spacing: 2){
                Image(systemName: "heart")
                Text("\(review.likeCnt)")
                    .padding(.trailing,10)
                Image(systemName: "heart.slash")
                Text("\(review.dislikeCnt)")
                    .padding(.trailing,10)
                Text("·   " + review.createdAt.relativeTime())
            }
            .foregroundColor(.customIndigo.opacity(0.7))
            .font(.subheadline)
            .padding(.bottom,5)
    }
}
