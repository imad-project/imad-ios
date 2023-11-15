//
//  CommunitySearchView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/17.
//

import SwiftUI

struct CommunitySearchView: View {
    
    @StateObject var vm = CommunityViewModel(community: nil, communityList: [])
    
    @State var sortButton = false
    @State var orderButton = false
    @State var typeButton = false
    @State var text = ""
    
    @State var goCommunity = false
    @State var sort:SortFilter = .createdDate
    @State var order:OrderFilter = .ascending
    @State var type:SearchTypeFilter = .titleContents
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vmAuth:AuthViewModel
    var body: some View {
        VStack(alignment: .leading){
            header
            searchView
            ScrollView(.horizontal){
                HStack{
                    filterView(type: "search").padding(.leading)
                    filterView(type: "order")
                    filterView(type: "sort")
                }
            }
            ScrollView{
                ForEach(vm.communityList,id: \.self){ community in
//                    NavigationLink("\(community.contentsID)", value: community)
                    NavigationLink(value: community) {
                        CommunityListRowView(community: community).padding()
                    }
//                    NavigationLink {
//                        CommunityPostView(postingId: community.postingID, back: .constant(true))
//                    } label: {
//                        CommunityListRowView(community: community).padding()
//                    }
                }
            }
        }
        .navigationDestination(for: CommunityDetailsListResponse.self){ community in
            CommunityPostView(postingId: community.postingID, back: $goCommunity)
        }
        .foregroundColor(.customIndigo)
        .background(Color.white.ignoresSafeArea())
        .navigationBarBackButtonHidden()
        .onReceive(vm.refreschTokenExpired){
            vmAuth.logout(tokenExpired: true)
        }
    }
}

struct CommunitySearchView_Previews: PreviewProvider {
    static var previews: some View {
        CommunitySearchView(vm:CommunityViewModel(community: nil, communityList: []))
            .environmentObject(AuthViewModel(user: UserInfo(status: 1, message: "")))
    }
}
extension CommunitySearchView{
    var header:some View{
        HStack{
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
            }
            .padding(.leading)
            Text("커뮤니티 검색")
                .font(.title2)
                .bold()
                .padding(.leading)
        }
    }
    var searchView:some View{
        HStack{
            CustomTextField(password: false, image: "magnifyingglass", placeholder: "게시물을 검색해 주세요..", color:.gray, text: $text)
                .padding(15)
                .background(Color.gray.opacity(0.2).cornerRadius(20))
                .padding(.leading)
            Button {
                vm.communityList = []
                vm.readListConditionsAll(searchType: type.num, query: text, page: vm.currentPage, sort: sort.rawValue, order: order.rawValue)
            } label: {
                Text("검색")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.customIndigo)
                    .cornerRadius(20)
            }
            .padding(.trailing)
        }
    }
    func filterView(type:String) -> some View{
        Menu {
            switch type{
            case "search":
                Picker(selection: $type) {
                    ForEach(SearchTypeFilter.allCases,id:\.self){ type in
                        Text(type.name)
                    }
                } label: {}
            case "order":
                Picker(selection: $order) {
                    ForEach(OrderFilter.allCases,id:\.self){ order in
                        Text(order.name)
                    }
                } label: {}
            case "sort":
                Picker(selection: $sort) {
                    ForEach(SortFilter.allCases,id:\.self){ sort in
                        Text(sort.name)
                    }
                } label: {}
            default: Text("")
            }
        } label: {
            HStack{
                switch type{
                case "search":
                    Text(self.type.name)
                        .font(.caption)
                case "order":
                    Text(self.order.name)
                        .font(.caption)
                case "sort":
                    Text(self.sort.name)
                        .font(.caption)
                default: Text("")
                }
                Image(systemName: "chevron.down")
                    .font(.caption)
            }
        }
        .padding(.vertical,5)
        .padding(.horizontal)
        .background(Capsule().stroke(lineWidth: 1).foregroundColor(.customIndigo))
        
        .padding(.vertical,5)
    }
}
