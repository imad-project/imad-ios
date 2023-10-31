//
//  CommunityView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/06.
//

import SwiftUI
import Kingfisher

struct CommunityView: View {
    
    @State var searchView = false
    @State var search = false

    
    @StateObject var tab = CommunityTabViewModel()
    @StateObject var vm = CommunityViewModel()
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var list:[CommuityDetailsResponseList]{
        switch tab.communityTab{
        case .all:
            return vm.communityList
        case .free:
            return vm.communityList.filter({$0.category == 1})
        case .question:
            return vm.communityList.filter({$0.category == 2})
        case .debate:
            return vm.communityList.filter({$0.category == 3})
        }
    }
    
    var body: some View {
        NavigationView{
                VStack(spacing: 0) {
                    Section(header:header){
                        ScrollView{
                            ForEach(list,id:\.self){ community in
                                NavigationLink {
                                    CommunityPostView(postingId: community.postingID)
                                        .environmentObject(vmAuth)
                                } label: {
                                    CommunityListRowView(community: community)
                                        .padding(5)
                                }
                            }
                        }
                    }
                }
                .background(Color.white)
                .ignoresSafeArea()
                .onAppear{
                    vm.communityList = []
                    vm.readCommunityList(page: vm.page)
                }
                .onChange(of: tab.communityTab){ newValue in
                    if tab.communityTab == .all{
                        vm.communityList = []
                        vm.readCommunityList(page: vm.page)
                        //전체리스트 조회
                    }else{
                        vm.communityList = []
                        vm.readListConditionsAll(searchType: 0, query: "", page: vm.page, sort: "createdDate", order: 0)
                        //특정 필터 리스트 조회
                    }
                }
        }
        .navigationDestination(isPresented: $search){
            WorkListView(postingMode: true, title: "검색", back: $search)
                .environmentObject(vmAuth)
                .navigationBarBackButtonHidden(true)
        }
        .navigationDestination(isPresented: $searchView) {
            CommunitySearchView()
        }
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
            .environmentObject(AuthViewModel())
    }
}

extension CommunityView{
    
    var header:some View{
        VStack{
            HStack{
                Text("커뮤니티")
                    .font(.title2)
                    .bold()
                    .padding(.leading)
                    
                Spacer()
                Button {
                    searchView = true
                } label: {
                    Image(systemName:"magnifyingglass")
                        .font(.title3).bold()
                }.padding(.trailing)
                Button {
                    search = true
                } label: {
                    Image(systemName:"plus.viewfinder")
                        .font(.title3).bold()
                }.padding(.trailing)
            }
            
            
            
            category
            
        }
        .foregroundColor(.customIndigo)
        .padding(.vertical)
        .padding(.top,30)
        .background{
            Color.white
        }
       
        
    }
    var category:some View{
        GeometryReader{ geo in
            let width = geo.size.width/1.5
            HStack{
                ForEach(CommunityFilter.allCases,id:\.self){ item in
                    Button {
                        withAnimation(.easeIn(duration: 0.2)){
                            tab.communityTab = item
                        }
                    } label: {
                        Text(item.name)
                            .font(.callout)
                            .bold()
                            
                    }
                    Spacer()
                }
                
            }
            .frame(width: width)
            
            .overlay(alignment:.leading){
                Capsule()
                    .frame(width: 42.5,height: 3)
                    .offset(x:tab.indicatorOffset(width: width)-1)
                    .padding(.top,45)
            }.padding(.leading)
            
        }
        .frame(maxHeight: 20)
        
        
            
    }
//    func communityList() -> some View{
//        ScrollView(showsIndicators: false){
//            ForEach(CustomData.instance.reviewList.shuffled(),id: \.self){ item in
//                NavigationLink {
//                    CommunityPostView(review: post)
//                } label: {
//                    CommunityListRowView(title:item.title, image: item.thumbnail,community: CustomData.instance.community).padding()
//
//                }
//                Divider().padding(.horizontal)
//            }
//            .tag(CommunityFilter.all)
//        }.padding(.bottom,40).background(Color.white)
//    }

}
