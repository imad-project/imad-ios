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
    //    @State var like = 0
    //    @State var anima = false
    @State var menu = false
    @State var delete = false
    //    @State var tokenExpired = (false,"")
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = ReviewViewModel(review: nil, reviewList: [])
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var body: some View {
        ScrollView{
            
            LazyVStack(alignment: .leading,pinnedViews: [.sectionHeaders]) {
                if let review = vm.review{
                    Section {
                        profileAndDataView(review: review)
                        workInfoView(review: review)
                        if goWork{
                            workInfoNavigation(review: review)
                        }
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
        .confirmationDialog("ㅇㅇㅇ", isPresented: $delete){
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
        //        .onReceive(vm.tokenExpired) { messages in
        //            tokenExpired = (true,messages)
        //        }
        //        .alert(isPresented: $tokenExpired.0) {
        //            Alert(title: Text("토큰 만료됨"),message: Text(tokenExpired.1),dismissButton:.cancel(Text("확인")){
        ////                vmAuth.loginMode = false
        //            })
        //        }
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
                
                if vmAuth.user?.data?.nickname == review.userNickname{
                    ZStack{
                        Button {
                            withAnimation {
                                menu.toggle()
                            }
                        } label: {
                            Image(systemName: "ellipsis")
                                .font(.title3)
                        }
                        
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
        .overlay(alignment: .bottomTrailing) {
            if menu{
                VStack{
                    NavigationLink {
                        WriteReviewView(id: review.contentsID, image:review.contentsPosterPath.getImadImage(), gradeAvg: review.score,reviewId : review.reviewID, title: review.title,text:review.content,spoiler: review.spoiler,rating:review.score)
                            .navigationBarBackButtonHidden()
                            .environmentObject(vmAuth)
                    } label: {
                        Text("수정하기")
                    }
                    Divider()
                    Button {
                        delete = true
                    } label: {
                        Text("삭제하기")
                            .foregroundColor(.red)
                    }
                }
                .padding(.vertical)
                .font(.subheadline)
                .background(Color.white)
                .frame(width: 100,height: 80)
                .cornerRadius(5)
                .shadow(radius: 10)
                .offset(y:80)
                .padding(.trailing)
            }
        }
        
    }
    func profileAndDataView(review:ReadReviewResponse) -> some View{
        HStack{
            ProfileImageView(imageCode: review.userProfileImage,widthHeigt: 25)
            Text(vm.review?.userNickname ?? "")
            Spacer()
            Group{
                if review.createdAt != review.modifiedAt{
                    Text("수정됨 ·").bold()
                    Text(review.modifiedAt.relativeTime())
                }else{
                    Text(review.createdAt.relativeTime())
                }
            }.foregroundColor(.gray)
                .font(.caption)
        }
        .padding(.horizontal)
    }
    func workInfoView(review:ReadReviewResponse)->some View{
        HStack(alignment: .top) {
            KFImageView(image: review.contentsPosterPath.getImadImage(),width: 100,height:120)
            VStack(alignment: .leading) {
                Text("#" + (review.contentsTitle)).bold().font(.subheadline)
                Text(review.spoiler ? "스포일러" : "클린")
                    .font(.caption)
                    .padding(2)
                    .padding(.horizontal)
                    .background(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
                Text(vm.review?.title ?? "")
                    .font(.subheadline).bold()
                
            }
            Spacer()
            ScoreView(score: review.score,color:.black,font:.subheadline,widthHeight:70)
                .padding(.bottom)
        }.padding(.horizontal)
    }
    func workInfoNavigation(review:ReadReviewResponse) -> some View{
        NavigationLink {
            WorkView(contentsId:review.contentsID)
                .navigationBarBackButtonHidden()
                .environmentObject(vmAuth)
        } label: {
            HStack(spacing:1){
                Text(review.contentsTitle).bold()
                Text("의 상세정보 보러가기")
                Spacer()
                Image(systemName: "chevron.right")
            }.font(.caption)
                .padding(10)
                .background(Color.white).cornerRadius(10).shadow(radius: 1)
                .padding(.horizontal)
        }.padding(.vertical,7.5)
    }
    func contentAndLikeView(review:ReadReviewResponse) -> some View{
        VStack(alignment: .leading){
            Text(review.content)
                .font(.subheadline).padding(.horizontal)
            VStack(alignment: .leading){
                VStack(alignment: .trailing){
                    Divider()
                    HStack{
                        Group{
                            Button {
                                vm.like(review: review)
                            } label: {
                                Image(systemName: review.likeStatus == 1 ? "heart.fill":"heart")
                                Text("좋아요")
                            }
                            .foregroundColor(review.likeStatus == 1 ? .red : .gray)
                            Button {
                                vm.disLike(review: review)
                            } label: {
                                HStack{
                                    Image(systemName: review.likeStatus == -1 ? "heart.slash.fill" : "heart.slash")
                                    Text("싫어요")
                                }
                            }
                            .foregroundColor(review.likeStatus == -1 ? .blue : .gray)
                        }
                        .font(.subheadline)
                        .frame(maxWidth: .infinity)
                    }
                    Divider()
                    HStack(spacing: 2){
                        Image(systemName: "heart.fill").foregroundColor(.red)
                        Text("\((review.likeCnt))개")
                            .padding(.trailing)
                        Image(systemName: "heart.slash.fill").foregroundColor(.blue)
                        Text("\((review.dislikeCnt))개")
                    }
                    .font(.subheadline)
                }.padding(.vertical)
            }.padding()
        }
    }
    
    
}
