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
        ScrollView{
            LazyVStack(alignment: .leading,pinnedViews: [.sectionHeaders]) {
                if let review = vm.review{
                    Section {
                        workInfoView(review: review)
                        contentAndLikeView(review: review)
                    } header: {
                        header(review: review)
                    }
                }
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
        .ignoresSafeArea()
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
                        .font(.title3)
                }
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
                                WriteReviewView(id: review.contentsID, image:review.contentsPosterPath.getImadImage(), gradeAvg: review.score,reviewId : review.reviewID, title: review.title,text:review.content,spoiler: review.spoiler,rating:review.score)
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
            .overlay{
                Text("리뷰").bold()
            }
            .padding(.bottom,10)
            .padding(.horizontal)
            Divider()
        }
        .padding(.top,60)
        .background(Color.white)
        
    }
 
    func workInfoView(review:ReadReviewResponse)->some View{
        VStack(alignment: .leading) {
            Text("#" + review.contentsTitle)
                .bold()
            HStack(alignment: .top) {
                if goWork{
                    NavigationLink {
                        WorkView(contentsId:review.contentsID)
                            .navigationBarBackButtonHidden()
                            .environmentObject(vmAuth)
                    } label: {
                        KFImageView(image: review.contentsPosterPath.getImadImage(),width: 100,height:120)
                    }
                }else{
                    KFImageView(image: review.contentsPosterPath.getImadImage(),width: 100,height:120)
                }
                VStack(alignment: .leading) {
                    HStack{
                        ProfileImageView(imageCode: review.userID ?? 0, widthHeigt: 20)
                        Text(review.userNickname)
                        Group{
                            if review.createdAt != review.modifiedAt{
                                Text("수정됨").bold()
                                Text("· " + review.modifiedAt.relativeTime())
                            }else{
                                Text("· " + review.createdAt.relativeTime())
                            }
                        }.foregroundColor(.gray)
                            .font(.caption)
                    }
                    .font(.subheadline)
                    Text(vm.review?.title ?? "").bold()
                    
                }
                Spacer()
                ScoreView(score: review.score,color:.black,font:.subheadline,widthHeight:70)
                    .padding(.bottom)
            }
        }
        .padding(.horizontal)
    }
    func contentAndLikeView(review:ReadReviewResponse) -> some View{
        VStack(alignment: .leading){
            Text(review.content)
                .font(.subheadline).padding(.horizontal)
                .padding(.vertical)
            likeStatusView(review: review)
        }
    }
    func likeStatusView(review:ReadReviewResponse) -> some View{
        VStack{
            HStack{
                Text("\(vm.review?.likeCnt ?? 0)")
                Button {
                    vm.like(review: review)
                } label: {
                    Circle()
                        .foregroundColor(vm.review?.likeStatus == 1 ? .red.opacity(0.7): .red.opacity(0.3))
                        .frame(width: 50)
                        .overlay {
                            Image(systemName:"heart.fill")
                                .foregroundColor(.white)
                        }
                }
                Spacer().frame(width: 20)
                Button {
                    vm.disLike(review: review)
                } label: {
                    Circle()
                        .foregroundColor(vm.review?.likeStatus == -1 ? .blue.opacity(0.7): .blue.opacity(0.3))
                        .frame(width: 50)
                        .overlay {
                            Image(systemName:"hand.thumbsdown.fill")
                                .foregroundColor(.white)
                        }
                }
                Text("\(vm.review?.dislikeCnt ?? 0)")
            }
            .font(.title3)
            .frame(maxWidth: .infinity)
        }
    }
}
