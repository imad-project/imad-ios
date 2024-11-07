//
//  ScrapListView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/22.
//

import SwiftUI

struct MyScrapListView: View {
    
    @State var scrap:ScrapListResponse? = nil
    @State var goPosting = false
    @StateObject var vm = ScrapViewModel(scrapList: [])
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack(spacing:0){
            header
            ScrollView{
                ForEach(vm.scrapList,id: \.self){ scrap in
                    scrapListRowView(scrap: scrap)
                    if vm.scrapList.last == scrap,vm.currentPage < vm.maxPage{
                        ProgressView()
                            .onAppear{
                                vm.readScrapList(page: vm.currentPage + 1)
                            }
                    }
                }
            }
            .background(Color.gray.opacity(0.1))
        }
        .onAppear{
            vm.currentPage = 1
            vm.readScrapList(page: vm.currentPage)
        }
        .onDisappear{
            vm.currentPage = 1
            vm.scrapList.removeAll()
        }
        .navigationDestination(isPresented: $goPosting){
            PostingDetailsView(reported: false, postingId: scrap?.postingID ?? 0, back: $goPosting)
               
                .navigationBarBackButtonHidden()
        }
        .foregroundColor(.black)
    }
}

struct MyScrapListView_Previews: PreviewProvider {
    static var previews: some View {
        MyScrapListView(vm: ScrapViewModel(scrapList: CustomData.scrapList))
           
    }
}

extension MyScrapListView{
    var header:some View{
        VStack{
            HStack{
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .bold()
                    
                }
                Text("내 스크랩")
                    .font(.GmarketSansTTFMedium(25))
                    .bold()
                Spacer()
                
            }
            .padding(10)
            Divider()
        }
    }
    func scrapListRowView(scrap:ScrapListResponse) -> some View{
        Button {
            self.scrap = scrap
            self.goPosting = true
        } label: {
            CommunityListRowView(community: CommunityDetailsListResponse(postingID: scrap.postingID, contentsID: scrap.contentsID, contentsTitle: scrap.contentsTitle, contentsPosterPath: scrap.contentsPosterPath, userID: scrap.userID, userNickname: scrap.userNickname, userProfileImage: scrap.userProfileImage, title: scrap.postingTitle, category: 0, viewCnt: -1, likeCnt: -1, dislikeCnt: -1, likeStatus: -1, commentCnt: -1, createdAt: scrap.createdDate, modifiedAt: "", scrapId: scrap.scrapID, scrapStatus: true, reported: false, spoiler: false))
        }
    }
}
