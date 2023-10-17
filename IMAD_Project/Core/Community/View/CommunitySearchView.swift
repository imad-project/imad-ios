//
//  CommunitySearchView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/17.
//

import SwiftUI

struct CommunitySearchView: View {
    
    @StateObject var vm = CommunityViewModel()
    
    @State var sortButton = false
    @State var orderButton = false
    @State var typeButton = false
    @State var text = ""
    
    @State var sort:SortFilter = .createdDate
    @State var order:OrderFilter = .ascending
    @State var type:SearchTypeFilter = .titleContents
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading){
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
            HStack{
                CustomTextField(password: false, image: "magnifyingglass", placeholder: "게시물을 검색해 주세요..", color:.gray, text: $text)
                    .padding(15)
                    .background(Color.gray.opacity(0.2).cornerRadius(20))
                    .padding(.leading)
                Button {
                    vm.communityList = []
                    vm.readListConditionsAll(searchType: type.num, query: text, page: vm.page, sort: sort.rawValue, order: order.rawValue)
                } label: {
                    Text("검색")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.customIndigo)
                        .cornerRadius(20)
                }
                .padding(.trailing)

                
            }
            ScrollView(.horizontal){
                HStack{
                    Menu {
                        Picker(selection: $type) {
                            ForEach(SearchTypeFilter.allCases,id:\.self){ type in
                                Text(type.name)
                            }
                        } label: {}
                    } label: {
                        HStack{
                            Text(type.name)
                                .font(.caption)
                            Image(systemName: "chevron.down")
                                .font(.caption)
                        }
                    }
                    .padding(.vertical,5)
                    .padding(.horizontal)
                        .background(Capsule().stroke(lineWidth: 1).foregroundColor(.customIndigo))
                        .padding(.leading)
                        .padding(.vertical,5)
                    Menu {
                        Picker(selection: $order) {
                            ForEach(OrderFilter.allCases,id:\.self){ order in
                                Text(order.name)
                            }
                        } label: {}
                    } label: {
                        HStack{
                            Text(order.name)
                                .font(.caption)
                            Image(systemName: "chevron.down")
                                .font(.caption)
                        }
                    }
                    .padding(.vertical,5)
                    .padding(.horizontal)
                        .background(Capsule().stroke(lineWidth: 1).foregroundColor(.customIndigo))
                        .padding(.vertical,5)
                    Menu {
                        Picker(selection: $sort) {
                            ForEach(SortFilter.allCases,id:\.self){ sort in
                                Text(sort.name)
                            }
                        } label: {}
                    } label: {
                        HStack{
                            Text(sort.name)
                                .font(.caption)
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
            ScrollView{
                ForEach(vm.communityList,id: \.self){ community in
                    NavigationLink {
                        CommunityPostView(postingId: community.postingID)
                    } label: {
                        CommunityListRowView(community: community).padding()
                    }
                }
            }
        }.foregroundColor(.customIndigo)
            .background(Color.white.ignoresSafeArea())
            .navigationBarBackButtonHidden()
    }
}

struct CommunitySearchView_Previews: PreviewProvider {
    static var previews: some View {
        CommunitySearchView()
    }
}
