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
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var body: some View {
        VStack{
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
        }
        .onAppear{
            vm.readScrapList(page: vm.currentPage)
        }
        .navigationDestination(isPresented: $goPosting){
            CommunityPostView(postingId: scrap?.postingId ?? 0, back: $goPosting)
        }
        .foregroundColor(.black)
    }
}

struct MyScrapListView_Previews: PreviewProvider {
    static var previews: some View {
        MyScrapListView(vm: ScrapViewModel(scrapList: CustomData.instance.scrapList))
            .environmentObject(AuthViewModel(user: UserInfo(status: 0, message: "")))
    }
}

extension MyScrapListView{
    var header:some View{
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
            Text("내 스크랩")
                .bold()
        }
    }
    func scrapListRowView(scrap:ScrapListResponse) -> some View{
        Button {
            self.scrap = scrap
            self.goPosting = true
        } label: {
            HStack{
                VStack(alignment: .leading) {
                    Text(scrap.postingTitle)
                        .lineLimit(2)
                    HStack{
                        Circle().frame(width: 20)
                        Text("사용자 이름")
                        Text("· \(scrap.createdDate.relativeTime())")
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                }
                Spacer()
                KFImageView(image: CustomData.instance.movieList.first!,width: 80,height: 80)
            }
        }
        .padding(.horizontal)
    }
}
