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
    @StateObject var vm = ReviewViewModel(review:nil,reviewList: [])
    
    var body: some View {
        VStack(alignment: .leading){
            profileAndDateView
            HStack{
                contentView
                Spacer()
                scoreAndLike
            }
            likeView
        }
        .onAppear{
            vm.review = review
        }
    }
    
    
}

struct ReviewListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewListRowView(review: CustomData.instance.review,vm: ReviewViewModel(review:CustomData.instance.review,reviewList: CustomData.instance.reviewDetail))
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
                .foregroundColor(.red)
            }
            Spacer()
        }
        .padding(.bottom,5)
    }
    var contentView:some View{
        VStack(alignment: .leading) {
            Text(review.title).bold()
                .font(.system(size: 17))
            HStack{
                Text(review.spoiler ? "스포일러가\n포함된 리뷰입니다." : review.content)
                    .font(.system(size: 16))
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom,5)
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
                Text("\((vm.review?.likeCnt ?? 0))")
                    .padding(.trailing,10)
                Image(systemName: "heart.slash")
                Text("\((vm.review?.dislikeCnt ?? 0))")
                    .padding(.trailing,10)
                Text("·   " + review.createdAt.relativeTime())
            }
            .foregroundColor(.customIndigo.opacity(0.7))
            .font(.subheadline)
            .padding(.bottom)
    }
}
