//
//  CommunityView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/06.
//

import SwiftUI

struct CommunityView: View {
    
    @State var posting = false
    @State var post = CustomData.instance.reviewList.first!
    @StateObject var vm = CommunityTabViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack{
                VStack(spacing: 0) {
                    Section(header:header){
                        TabView(selection: $vm.communityTab) {
                            Group{
                                List(CustomData.instance.reviewList.shuffled(),id: \.self){ item in
                                    Button {
                                        post = item
                                        posting = true
                                    } label: {
                                        CommunityListRowView(image: item.thumbnail,community: CustomData.instance.community, textColor: .primary)
                                            
                                    }.listRowBackground(Color.clear)
                                }
                                .tag(CommunityFilter.free)
                                List(CustomData.instance.reviewList.shuffled(),id: \.self){ item in
                                    Button {
                                        post = item
                                        posting = true
                                    } label: {
                                        CommunityListRowView(image: item.thumbnail,community: CustomData.instance.community, textColor: .primary)
                                            
                                    }.listRowBackground(Color.clear)
                                }
                                .tag(CommunityFilter.question)
                                List(CustomData.instance.reviewList.shuffled(),id: \.self){ item in
                                    Button {
                                        post = item
                                        posting = true
                                    } label: {
                                        CommunityListRowView(image: item.thumbnail,community: CustomData.instance.community, textColor: .primary)
                                            
                                    }.listRowBackground(Color.clear)
                                }
                                .tag(CommunityFilter.debate)
                            }.background{
                                if colorScheme == .dark {
                                    LinearGradient(colors: [.black,.customIndigo], startPoint: .top, endPoint: .bottom)
                                }else{
                                    Color.white
                                }
                            }
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)   //리스트 배경 없음
                        .padding(.bottom,80)
                        
                    }
                }
                
                .navigationDestination(isPresented: $posting) {
                    CommunityPostView(isReview: $posting, review: post)
                  
                }.ignoresSafeArea()
        }.onDisappear{
            posting = false
        }
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
    }
}

extension CommunityView{
    var header:some View{
        VStack{
            HStack{
                Text("커뮤니티")
                    .font(.title)
                    .bold()
                    .padding(.leading)
                    
                Spacer()
                Image(systemName: "magnifyingglass")
                    .font(.title)
                    .padding(.trailing)
            }
            category
            
        }
        .foregroundColor(.indigoNotPrimary)
        .padding(.vertical)
        .padding(.top,30)
        .background{
            if colorScheme == .dark {
                Color.white
            }else{
                LinearGradient(colors: [.black,.customIndigo], startPoint: .top, endPoint: .bottom)
            }
        }
        
    }
    var category:some View{
        GeometryReader{ geo in
            let width = geo.size.width/2
            HStack{
                ForEach(CommunityFilter.allCases,id:\.self){ item in
                    Button {
                        withAnimation(.easeIn(duration: 0.2)){
                            vm.communityTab = item
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
                    .offset(x:vm.indicatorOffset(width: width))
                    .padding(.top,45)
            }.padding(.leading)
            
        }
        .frame(maxHeight: 20)
        
            
    }
}
