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
            Divider()
            likeView
        }
        .onAppear{
            vm.review = review
//            like = review.likeStatus
        }
//        .onReceive(vm.success) {
//            review.likeCnt = vm.review?.likeCnt ?? 0
//            review.dislikeCnt = vm.review?.dislikeCnt ?? 0
//        }
        
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
            ProfileImageView(imageCode: review.userProfileImage,widthHeigt: 25)
            Text(review.userNickname)
                .font(.subheadline)
                .bold()
            Spacer()
            Text(review.createdAt.relativeTime())
                .foregroundColor(.gray)
                .font(.caption)
            
        }
        .padding(.bottom,5)
    }
    var contentView:some View{
        VStack(alignment: .leading) {
            Text(review.title).bold()
                .padding(.vertical)
                .font(.subheadline)
            HStack{
                Text(review.content)
                    .font(.caption)
                    .lineLimit(5)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom,5)
                    .padding(.horizontal,5)
                Spacer()
            }
            .overlay {
                if review.spoiler{
                    Color.white.opacity(0.1)
                        .background(Material.ultraThin).environment(\.colorScheme, .light)
                        .cornerRadius(5)
                    Text("「스포일러성 리뷰입니다.」")
                }
            }
            
        }
    }
    var scoreAndLike:some View{
        VStack{
            ScoreView(score: review.score, color: .black,font: .subheadline,widthHeight: 60)
            HStack(spacing: 15){
                HStack(spacing: 2){
                    Image(systemName: "heart.fill").foregroundColor(.red)
                    Text("\((vm.review?.likeCnt ?? 0))")
                        .padding(.trailing)
                    Image(systemName: "heart.slash.fill").foregroundColor(.blue)
                    Text("\((vm.review?.dislikeCnt ?? 0))")
                }
                .font(.subheadline)
            }
            .font(.subheadline)
        }.padding(.horizontal)
    }
    var likeView:some View{
        HStack{
            Group{
                Button {
                    vm.like(review:vm.review ?? review)
                } label: {
                    Image(systemName: vm.review?.likeStatus == 1 ? "heart.fill":"heart")
                    Text("좋아요")
                }
                .foregroundColor(vm.review?.likeStatus == 1 ? .red : .gray)
                Button {
                    vm.disLike(review: vm.review ?? review)
                } label: {
                    HStack{
                        Image(systemName: vm.review?.likeStatus == -1 ? "heart.slash.fill" : "heart.slash")
                        Text("싫어요")
                    }
                }
                .foregroundColor(vm.review?.likeStatus == -1 ? .blue : .gray)
            }
            .font(.subheadline)
            .padding(.bottom)
            .frame(maxWidth: .infinity)
        }
    }
}
