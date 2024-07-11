//
//  ReviewDetailsView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/09/12.
//

import SwiftUI
import Kingfisher

struct ReviewDetailsView: View {
    
    let goWork:Bool //작품상세정보
    let reviewId:Int
    @State var menu = false
    @State var delete = false
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = ReviewViewModel(review: nil, reviewList: [])
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var body: some View {
        VStack(spacing: 0){
            if let review = vm.review{
                header(review: review)
                ScrollView{
                    VStack{
                        Divider()
                        workInfoView(review: review)
                        contentAndLikeView(review: review)
                        Divider()
                    }
                    .background(Color.white)
                    .padding(.top,10)
                }
                .background(Color.gray.opacity(0.1))
            }
        }
        
        .onReceive(vm.refreschTokenExpired){
            vmAuth.logout(tokenExpired: true)
        }
        .onTapGesture {
            menu = false
        }
        .confirmationDialog("", isPresented: $delete){
            Button(role:.destructive){
                vm.deleteReview(id: reviewId)
                dismiss()
            } label: {
                Text("삭제")
            }
            Button("취소", role: .cancel) {}
        } message: {
            Text("리뷰를 삭제하시겠습니까?")
        }
        .background(Color.white)
        .foregroundColor(.black)
        .onAppear{
            vm.readReview(id: reviewId)
        }
        .onDisappear{
            menu = false
        }
    }
}

struct ReviewDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ReviewDetailsView(goWork: true, reviewId: 1,vm: ReviewViewModel(review:CustomData.instance.review,reviewList: CustomData.instance.reviewDetail))
                .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
        }
    }
}

extension ReviewDetailsView{
    func header(review:ReadReviewResponse) ->some View{
        VStack{
            HStack{
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .bold()
                }
                Text("리뷰")
                    .bold()
                    .font(.GmarketSansTTFMedium(25))
                Spacer()
                
                if review.author{
                    ZStack{
                        Button {
                            withAnimation {
                                menu.toggle()
                            }
                        } label: {
                            Image(systemName: "ellipsis")
                                .font(.title3)
                        }
                        .confirmationDialog("", isPresented: $menu,actions: {
                            NavigationLink {
                                WriteReviewView(id: review.contentsID, image:review.contentsPosterPath.getImadImage(), workName: review.contentsTitle, gradeAvg: review.score,reviewId : review.reviewID, title: review.title,text:review.content,spoiler: review.spoiler,rating:review.score)
                                    .navigationBarBackButtonHidden()
                                    .environmentObject(vmAuth)
                            } label: {
                                Text("수정하기")
                            }
                            Button(role:.destructive){
                                delete = true
                            } label: {
                                Text("삭제하기")
                            }
                        },message: {
                            Text("리뷰 수정하거나 삭제하시겠습니까?")
                        })
                    }
                }
            }
            .padding(10)
            Divider()
        }
        .background(Color.white)
        
        
    }
    
    func workInfoView(review:ReadReviewResponse)->some View{
        VStack(alignment: .leading) {
            HStack{
                VStack(alignment: .leading) {
                    HStack{
                        ProfileImageView(imagePath: review.userProfileImage, widthHeigt: 40)
                        VStack(alignment: .leading){
                            Text(review.userNickname)
                                .font(.GmarketSansTTFMedium(13))
                                .fontWeight(.semibold)
                            Group{
                                if review.createdAt != review.modifiedAt{
                                    Text("수정됨").bold()
                                    Text( review.modifiedAt.relativeTime())
                                }else{
                                    Text( review.createdAt.relativeTime())
                                }
                            }
                            .foregroundColor(.gray)
                            .font(.caption)
                            .font(.subheadline)
                        }
                    }
                    
                    Text(vm.review?.title ?? "")
                        .font(.GmarketSansTTFMedium(20))
                        .fontWeight(.semibold)
                        .padding(.top,5)
                }
                Spacer()
                ScoreView(score: review.score,color:.black,font:.subheadline,widthHeight:70)
            }
        }
        .padding(10)
    }
    func contentAndLikeView(review:ReadReviewResponse) -> some View{
        VStack(alignment: .leading){
            Text(review.content)
                .font(.subheadline)
                .padding(.bottom)
            if goWork{
                NavigationLink {
                    WorkView(contentsId:review.contentsID)
                        .navigationBarBackButtonHidden()
                        .environmentObject(vmAuth)
                } label: {
                    HStack{
                        KFImageView(image: review.contentsPosterPath.getImadImage(),width: 30,height:40)
                        Text(review.contentsTitle)
                            .font(.GmarketSansTTFMedium(15))
                            .bold()
                        Spacer()
                        Image(systemName: "chevron.right")
                            .padding(.trailing)
                    }
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(radius: 1)
                    
                }
            }
            likeStatusView(review: review)
        }
        .padding(.horizontal,10)
    }
    func likeStatusView(review:ReadReviewResponse) -> some View{
        HStack{
            Button {
                vm.like(review: review)
            } label: {
                HStack{
                    Image(systemName:"arrowshape.up.fill")
                        .foregroundColor(.white)
                    Text("추천")
                        .font(.GmarketSansTTFMedium(15))
                    Text("\(vm.review?.likeCnt ?? 0)")
                }
                .foregroundColor(.white)
                .frame(height:35)
                .frame(maxWidth: .infinity)
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.customIndigo.opacity(vm.review?.likeStatus == 1 ? 1 : 0.5))
                }
            }
            Spacer()
            Button {
                vm.disLike(review: review)
            } label: {
                HStack{
                    Image(systemName:"arrowshape.down.fill")
                        .foregroundColor(.white)
                    Text("비추천")
                        .font(.GmarketSansTTFMedium(15))
                    Text("\(vm.review?.dislikeCnt ?? 0)")
                }
                .foregroundColor(.white)
                .frame(height:35)
                .frame(maxWidth: .infinity)
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.customIndigo.opacity(vm.review?.likeStatus == -1 ? 1 : 0.5))
                }
            }
        }
        .padding(.vertical)
    }
}
