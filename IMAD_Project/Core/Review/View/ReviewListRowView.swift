//
//  ReviewListRowView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/09/15.
//

import SwiftUI
import Kingfisher

struct ReviewListRowView: View {
    @State var review:ReviewDetailsResponseList
    @State var like = 0
    @State var isExtend = false
    @State var anima = false
    @StateObject var vm = ReviewViewModel(reviewList: [])
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image(ProfileFilter.allCases.first(where: {$0.num == (review.userProfileImage )})?.rawValue ?? "soso")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 25,height: 25)
                Text(review.userNickname)
                    .font(.subheadline)
                    .bold()
                Spacer()
                Text(review.createdAt.relativeTime())
                    .foregroundColor(.gray)
                    .font(.caption)
                
            }
            .padding(.bottom,5)
            
            
            HStack{
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
                
                Spacer()
                VStack{
                    Circle()
                        .trim(from: 0.0, to: anima ? (review.score) * 0.1 : 0)
                        .stroke(lineWidth: 3)
                        .rotation(Angle(degrees: 270))
                        .frame(width: 50,height: 50)
                        .overlay{
                            VStack{
                                Image(systemName: "star.fill")
                                Text(String(format: "%0.1f", (review.score)))
                            }
                            .font(.caption)
                            Circle().stroke(lineWidth:0.1)
                        }
                        .shadow(radius: 20)
                        .padding(.bottom)
                    HStack(spacing: 15){
                        HStack(spacing: 2){
                            Image(systemName: "heart.fill").foregroundColor(.red)
                            Text("\((review.likeCnt))")
                                .padding(.trailing)
                            Image(systemName: "heart.slash.fill").foregroundColor(.blue)
                            Text("\((review.dislikeCnt))")
                        }
                        .font(.subheadline)
                    }
                    .font(.subheadline)
                }.padding(.horizontal)
            }
            Divider()
            HStack{
                Group{
                    Button {
                        if like == 0 || like == -1{
                            like = 1
                            vm.likeReview(id: review.reviewID, status: like)
                        }else{
                            like = 0
                            vm.likeReview(id: review.reviewID, status: like)
                        }
                    } label: {
                        Image(systemName: like == 1 ? "heart.fill":"heart")
                        Text("좋아요")
                    }
                    .foregroundColor(like == 1 ? .red : .gray)
                    Button {
                        if like == 0 || like == 1{
                            like = -1
                            vm.likeReview(id: review.reviewID, status: like)
                            
                        }else{
                            like = 0
                            vm.likeReview(id: review.reviewID, status: like)
                        }
                    } label: {
                        HStack{
                            Image(systemName: like == -1 ? "heart.slash.fill" : "heart.slash")
                            Text("싫어요")
                        }
                    }
                    .foregroundColor(like == -1 ? .blue : .gray)
                }
                .font(.subheadline)
                .padding(.bottom)
                .frame(maxWidth: .infinity)
            }
        }
        .onAppear{
            like = review.likeStatus
            DispatchQueue.main.async {
                withAnimation(.linear(duration: 0.5)){
                    anima = true
                }
            }
        }
        .onReceive(vm.success) {
            review.likeCnt = vm.reviewInfo?.likeCnt ?? 0
            review.dislikeCnt = vm.reviewInfo?.dislikeCnt ?? 0
        }
        
    }
    
    
}

struct ReviewListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewListRowView(review: CustomData.instance.reviewDetail[1],vm: ReviewViewModel(reviewList: CustomData.instance.reviewDetail))
    }
}
