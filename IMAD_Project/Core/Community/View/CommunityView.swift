//
//  CommunityView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/06.
//

import SwiftUI
import Kingfisher


struct CommunityView: View {
    
    @State var communityTab:CommunityFilter = .all
    @State var tabInfo:CGFloat = 0
    @State var searchView = false
    @State var search = false
    @State var searchText = ""
    
    @State var goWork = false
    @State var sort:SortFilter = .createdDate
    @State var workInfo:CommunityDetailsListResponse?
    
    @StateObject var vm = CommunityViewModel(community: nil, communityList: [])
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var body: some View {
        VStack(spacing: 0){
            header
            category
            ScrollView(showsIndicators: false){
                infoView
                listView
            }
            .background(.gray.opacity(0.1))
        }
        .onChange(of: communityTab){ tab in
            listUpdate(category: tab.num)
        }
        .onAppear{
            listUpdate(category: communityTab.num)
        }
        .navigationDestination(isPresented: $goWork) {
            if let workInfo{
                CommunityPostView(reported: workInfo.reported, postingId: workInfo.postingID, back: $goWork)
                    .navigationBarBackButtonHidden()
                    .environmentObject(vmAuth)
            }
        }
        .navigationDestination(isPresented: $search){
            SearchView(backMode: false, postingMode: true, back: $search)
                .environmentObject(vmAuth)
                .navigationBarBackButtonHidden()
        }
        .navigationDestination(isPresented: $searchView) {
            CommunitySearchView()
                .environmentObject(vmAuth)
                .navigationBarBackButtonHidden()
        }
        .onReceive(vm.refreschTokenExpired){
            vmAuth.logout(tokenExpired: true)
        }
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            CommunityView(vm: CommunityViewModel(community:CustomData.instance.community, communityList: CustomData.instance.communityList))
                .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
        }
        
    }
}

extension CommunityView{
    
    var header:some View{
        VStack(alignment:.leading,spacing:0){
            HStack{
                Text("커뮤니티")
                    .font(.custom("GmarketSansTTFMedium", size: 25))
                    .bold()
                    .padding(.leading,10)
                    .padding(.bottom)
                Spacer()
                Button {
                    withAnimation {
                        searchView = true
                    }
                } label: {
                    Image(systemName:"magnifyingglass")
                        .font(.title3).bold()
                }.padding(.trailing)
                Button {
                    search = true
                } label: {
                    Image(systemName:"plus.viewfinder")
                        .font(.title3).bold()
                }.padding(.trailing,10)
            }
        }
        .foregroundColor(.customIndigo)
        .padding(.top,10)
    }
    var category:some View{
        HStack{
            ForEach(CommunityFilter.allCases,id:\.self){ item in
                GeometryReader{ geo in
                    let minX = geo.frame(in: .global).minX
                    Button {
                        withAnimation(.easeIn(duration: 0.2)){
                            tabInfo = minX
                            communityTab = item
                        }
                    } label: {
                        Text(item.name)
                            .font(.GmarketSansTTFMedium(15))
                    }
                    .onAppear{
                        if item == CommunityFilter.allCases.first{
                            self.tabInfo = minX
                        }
                    }
                }
                .frame(width: 45,height: 30)
                .frame(maxWidth: .infinity)
            }
        }
        .foregroundColor(.customIndigo)
        .overlay(alignment:.leading){
            Capsule()
                .frame(width: 45,height: 3)
                .offset(x:tabInfo,y:13.5)
        }
        .background{
            Divider().offset(y:13.5)
        }
    }
    
    var infoView:some View{
        HStack{
            Text("총 \(vm.totalOfElements)개")
                .fontWeight(.bold)
            Spacer()
            
            Button {
                sort = .createdDate
                listUpdate(category: communityTab.num)
            } label: {
                HStack(spacing:2){
                    Image(systemName: sort == .createdDate ? "checkmark" : "").fontWeight(.black)
                    Text("최신순")
                        .fontWeight(.bold)
                }
                .foregroundColor(.customIndigo.opacity(sort == .createdDate ? 1:0.5))
            }
            Text("·")
            Button {
                sort = .likeCnt
                listUpdate(category: communityTab.num)
            } label: {
                HStack(spacing:2){
                    Image(systemName: sort == .likeCnt ? "checkmark":"").fontWeight(.black)
                    Text("추천순")
                        .fontWeight(.bold)
                }
            }
            .foregroundColor(.customIndigo.opacity(sort == .createdDate ? 0.5:1))
        }
        .font(.subheadline)
        .padding(.vertical,10)
        .padding(.horizontal,10)
        .background(.white)
    }
    var listView:some View{
        ForEach(vm.communityList,id:\.self){ community in
            Button {
                workInfo = community
                goWork = true
            } label: {
                CommunityListRowView(community: community)
            }
            
            if vm.communityList.last == community,vm.maxPage > vm.currentPage{
                ProgressView()
                    .onAppear{
                        vm.readCommunityList(page: vm.currentPage + 1,category:communityTab.num)
                    }
            }
        }
    }
    func listUpdate(category:Int){
        vm.currentPage = 1
        vm.communityList.removeAll()
        vm.readListConditionsAll(searchType: 0, query: "", page: vm.currentPage, sort: sort.rawValue, order: 1,category: category)
    }
    
}
