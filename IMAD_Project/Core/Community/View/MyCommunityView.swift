//
//  MyCommunityView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/29.
//


import SwiftUI

struct MyCommunityView: View {
    let writeType:WriteTypeFilter
    @State var like = true
    @StateObject var vm = CommunityViewModel(community: nil, communityList: [])
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vmAuth:AuthViewModel
    
    func profileMode(next:Bool)->(){
        switch writeType{
        case .myself:
            return vm.myReviewList(page: next ? vm.currentPage + 1 : vm.currentPage)
        case .myselfLike:
            return vm.myLikeReviewList(page: next ? vm.currentPage + 1 : vm.currentPage, likeStatus: like ? 1 : -1)
        }
    }
    var reviewList:[ReadReviewResponse]{
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
        VStack{
            header
            item
        }
        .foregroundColor(.black)
        .background(Color.white)
        .onAppear{
            profileMode(next: false)
        }
        .onDisappear{
            vm.reviewList.removeAll()
        }
        .onReceive(vm.refreschTokenExpired){
            vmAuth.logout(tokenExpired: true)
        }
    }
}

struct MyCommunityView_Previews: PreviewProvider {
    static var previews: some View {
        MyCommunityView(writeType: .myselfLike,vm: ReviewViewModel(review:CustomData.instance.review,reviewList: CustomData.instance.reviewDetail))
            .environmentObject(AuthViewModel(user: UserInfo(status: 1, message: "")))
    }
}

extension MyCommunityView{
    var header:some View{
        VStack{
            ZStack{
                HStack{
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .bold()
                            .padding()
                        
                    }
                    Spacer()
                }
                Text(writeType == .myself ? "내 리뷰" : "내 리뷰 반응")
                    .font(.title3)
                    .bold()
            }
            if writeType == .myselfLike{
                HStack{
                    filterButton(like: true)
                    filterButton(like: false)
                    Spacer()
                }.padding(.leading)
            }
            Divider()
        }
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
                                ReviewDetailsView(goWork: true, reviewId: review.reviewID)
                                    .environmentObject(vmAuth)
                                    .navigationBarBackButtonHidden()
                            } label: {
                                MyReviewListRowView(review: review)
                                    .padding(.horizontal)
                            }.padding(.top,10)
                            Divider().padding(.vertical)
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
                Image(systemName: like ? "heart.fill" : "heart.slash.fill").foregroundColor(like ? .red:.blue)
                Text(like ? "좋아요":"싫어요")
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
                    .font(.largeTitle)
                    .padding(.bottom,5)
                Text("작성한 리뷰가 없습니다")
            }else{
                ZStack{
                    Image(systemName: "heart.fill")
                        .font(.title)
                        .foregroundColor(.blue)
                        .offset(x:3)
                        .rotationEffect(Angle(degrees: -10))
                    Image(systemName: "heart.fill")
                        .font(.title)
                        .foregroundColor(.red)
                        .offset(x:-3)
                        .rotationEffect(Angle(degrees: 10))
                }.opacity(0.6)
                Text("좋아요/싫어요가 없습니다")
            }
            Spacer()
        }
    }
}
