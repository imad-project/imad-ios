//
//  MyReviewListView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/19.
//

import SwiftUI

struct MyReviewListView: View {
    let writeType:WriteTypeFilter
    @State var like = true
    @StateObject var user = UserInfoManager.instance
    @StateObject var vm = ReviewViewModel(review: nil, reviewList: [])
    @Environment(\.dismiss) var dismiss
    
    
    func profileMode(next:Bool)->(){
        switch writeType{
        case .myself:
            return vm.readMyReviewList(page: next ? vm.currentPage + 1 : vm.currentPage)
        case .myselfLike:
            return vm.readMyLikeReviewList(page: next ? vm.currentPage + 1 : vm.currentPage, likeStatus: like ? 1 : -1)
        }
    }
    var reviewList:[ReviewResponse]{
        switch writeType{
        case .myself:
            return vm.reviewList
        case .myselfLike:
            if like{
                return vm.reviewList.filter({$0.likeStatus == 1})
            }else{
                return vm.reviewList.filter({$0.likeStatus == -1})
            }
        }
    }
    
    var body: some View {
        VStack(spacing:0){
            header
            item
        }
        .foregroundColor(.black)
        .background(Color.white)
        .onAppear{
            profileMode(next: false)
        }
        .onDisappear{
            vm.currentPage = 1
            vm.reviewList.removeAll()
        }
    }
}

struct MyReviewListView_Previews: PreviewProvider {
    static var previews: some View {
        MyReviewListView(writeType: .myselfLike,vm: ReviewViewModel(review:CustomData.review,reviewList: CustomData.reviewDetailList))
           
    }
}

extension MyReviewListView{
    var header:some View{
        VStack{
            HeaderView(backIcon: "chevron.left", text: writeType == .myself ? "내 리뷰" : "내 리뷰 반응"){
                dismiss()
            }.padding(.leading,10)
            if writeType == .myselfLike{
                HStack{
                    filterButton(like: true)
                    filterButton(like: false)
                    Spacer()
                }.padding(.leading)
            }
            Divider()
        }.padding(.top,10)
    }
    
    var item:some View{
        VStack{
            if vm.reviewList.isEmpty{
                emptyView
            }else{
                ScrollView{
                    ForEach(reviewList,id: \.self) { review in
                        VStack{
                            NavigationLink {
                                ReviewDetailsView(goWork: true, reviewId: review.reviewID, reported: review.reported)
                                   
                                    .navigationBarBackButtonHidden()
                            } label: {
                                ReviewListRowView(review: review, my: true)
                                   
                            }
                            if vm.reviewList.last == review,vm.maxPage > vm.currentPage{
                                ProgressView()
                                    .environment(\.colorScheme, .light)
                                    .onAppear{
                                        profileMode(next: true)
                                    }
                            }
                        }
                    }
                }
                .background(Color.gray.opacity(0.1))
            }
        }
    }
    func filterButton(like:Bool) -> some View{
        Button {
            withAnimation {
                self.like = like
                vm.reviewList.removeAll()
                profileMode(next: false)
            }
        } label: {
            HStack{
                Image(systemName: like ? "arrowshape.up.fill" : "arrowshape.down.fill").foregroundColor(.customIndigo.opacity(0.7))
                Text(like ? "추천":"비추천")
                    .font(.custom("GmarketSansTTFMedium",size: 15))
            }
            .padding(5)
            .padding(.horizontal)
            .background(Color.white)
            .overlay {
                if self.like != like{
                    Color.white.opacity(0.8)
                }
            }
            .cornerRadius(100)
            .shadow(radius: 1)
        }
    }
    var emptyView:some View{
        VStack{
            Spacer()
            if writeType == .myself{
                Image(systemName: "text.badge.xmark")
                    .font(.custom("GmarketSansTTFMedium", size: 50))
                    .foregroundColor(.customIndigo.opacity(0.5))
                    .padding(.bottom,5)
                Text("작성한 리뷰가 없습니다")
                    .font(.custom("GmarketSansTTFMedium", size: 15))
            }else{
                Image(systemName: like ? "arrowshape.up" : "arrowshape.down")
                    .font(.custom("GmarketSansTTFMedium", size: 50))
                    .foregroundColor(.customIndigo.opacity(0.5))
                    .padding(.bottom,5)
                Text(like ? "추천한 리뷰가 없습니다" : "비추천한 리뷰가 없습니다")
                    .font(.custom("GmarketSansTTFMedium", size: 15))
            }
            Spacer()
        }
    }
}
