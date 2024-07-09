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
    @State var searchText = ""
    
    @State var goWork = false
    @State var sort:SortFilter = .createdDate
    @State var workInfo:CommunityDetailsListResponse?
    
    @StateObject var tab = CommunityTabManager()
    @StateObject var vm = CommunityViewModel(community: nil, communityList: [])
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var body: some View {
        VStack(spacing: 0){
            header
            ScrollView(showsIndicators: false){
                infoView
                listView
            }
            .background(.gray.opacity(0.1))
        }
        .onChange(of: tab.communityTab){ tab in
            listUpdate(category: tab.num)
        }
        .onAppear{
            listUpdate(category: tab.communityTab.num)
        }
        .navigationDestination(isPresented: $goWork) {
            if let workInfo{
                CommunityPostView(postingId: workInfo.postingID, back: $goWork)
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
        VStack(alignment:.leading){
            HStack{
                Text("커뮤니티")
                    .font(.custom("GmarketSansTTFMedium", size: 25))
                    .bold()
                    .padding(.leading,10)
                    
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
            category
        }
        .foregroundColor(.customIndigo)
        .padding(.top,10)
    }
    var category:some View{
        GeometryReader{ geo in
            let width = geo.size.width
            HStack{
                ForEach(CommunityFilter.allCases,id:\.self){ item in
                    Button {
                        withAnimation(.easeIn(duration: 0.2)){
                            tab.communityTab = item
                        }
                    } label: {
                        Text(item.name)
                            .font(.custom("GmarketSansTTFMedium", size: 15))
                           
                    } .frame(maxWidth: .infinity)
                    
                }
                
            }
            .overlay(alignment:.leading){
                Capsule()
                    .frame(width: UIScreen.main.bounds.width/4 - 20,height: 3)
                    .offset(x:tab.indicatorOffset(width: width) + 10)
                    .padding(.top,45)
            }
            .frame(width: width)
        }
        .frame(maxHeight: 17)
        .padding(.bottom)
        .background{
            VStack(spacing: 0){
                Color.white
                Divider()
            }
            
        }
        
    }
    var infoView:some View{
        HStack{
            Text("총 \(vm.totalOfElements)개")
                .fontWeight(.bold)
            Spacer()
            
            Button {
                sort = .createdDate
                listUpdate(category: tab.communityTab.num)
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
                listUpdate(category: tab.communityTab.num)
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
                        vm.readCommunityList(page: vm.currentPage + 1,category:tab.communityTab.num)
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
