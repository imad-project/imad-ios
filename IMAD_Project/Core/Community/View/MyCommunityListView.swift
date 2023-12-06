//
//  MyCommunityListView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/29.
//

import SwiftUI

struct MyCommunityListView: View {
    let writeType:WriteTypeFilter
    
    @State var community:CommunityDetailsListResponse? = nil
    @State var goPosting = false
    @State var like = true
    
    @StateObject var vm = CommunityViewModel(community: nil, communityList: [])
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vmAuth:AuthViewModel
    
    func profileMode(next:Bool)->(){
        switch writeType{
        case .myself:
            return vm.myCommunity(page: next ? vm.currentPage + 1 : vm.currentPage)
        case .myselfLike:
            return vm.myLikeCommunity(page: next ? vm.currentPage + 1 : vm.currentPage, likeStatus: like ? 1 : -1)
        }
    }
    var communityList:[CommunityDetailsListResponse]{
        switch writeType{
        case .myself:
            return vm.communityList
        case .myselfLike:
            if like{
                return vm.communityList.filter({$0.likeStatus == 1})
            }else{
                return vm.communityList.filter({$0.likeStatus == -1})
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
            vm.communityList.removeAll()
        }
        .onReceive(vm.refreschTokenExpired){
            vmAuth.logout(tokenExpired: true)
        }
        .navigationDestination(isPresented: $goPosting){
            CommunityPostView(postingId: community?.postingID ?? 0, back: $goPosting)
        }
    }
}

struct MyCommunityListView_Previews: PreviewProvider {
    static var previews: some View {
        MyCommunityListView(writeType: .myself,vm: CommunityViewModel(community:CustomData.instance.community,communityList: CustomData.instance.communityList))
            .environmentObject(AuthViewModel(user: UserInfo(status: 1, message: "")))
    }
}

extension MyCommunityListView{
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
                Text(writeType == .myself ? "내 게시물" : "내 게시물 반응")
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
            if vm.communityList.isEmpty{
                emptyView
            }else{
                ScrollView{
                    ForEach(communityList,id: \.self) { community in
                        VStack{
                            communityListRowView(community: community)
                            Divider().padding(.vertical)
                            if vm.communityList.last == community,vm.maxPage > vm.currentPage{
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
                vm.communityList.removeAll()
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
                Text("작성한 게시물이 없습니다")
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
    func communityListRowView(community:CommunityDetailsListResponse) -> some View{
        Button {
            self.community = community
            self.goPosting = true
        } label: {
            HStack{
                VStack(alignment: .leading) {
                    Text(community.contentsTitle ?? "")
                        .lineLimit(2)
                    HStack{
                        ProfileImageView(imageCode: community.userProfileImage, widthHeigt: 20)
                        Text(community.userNickname)
                        Text("· \(community.createdAt.relativeTime())")
                            .foregroundColor(.gray)
                    }
                    .font(.caption)
                }
                Spacer()
                KFImageView(image:community.contentsPosterPath?.getImadImage() ?? "" ,width: 80,height: 80)
            }
        }
        .padding(.horizontal)
    }
}
