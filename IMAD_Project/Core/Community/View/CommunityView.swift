//
//  CommunityView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/06.
//

import SwiftUI
import Kingfisher

struct CommunityView: View {
    
  @State var search = false
    @State var post = CustomData.instance.reviewList.first!
    @StateObject var vm = CommunityTabViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView{
                VStack(spacing: 0) {
                    Section(header:header){
                        TabView(selection: $vm.communityTab) {
                            ScrollView(showsIndicators: false){
                                ForEach(CustomData.instance.reviewList.shuffled(),id: \.self){ item in
                                    NavigationLink {
                                        CommunityPostView(review: post)
                                    } label: {
                                        CommunityListRowView(title:item.title, image: item.thumbnail,community: CustomData.instance.community).padding()
                                        
                                    }
                                    Divider().padding(.horizontal)
                                }
                                .tag(CommunityFilter.all)
                            }.padding(.bottom,40).background(Color.white)
                            ScrollView(showsIndicators: false){
                                ForEach(CustomData.instance.reviewList.shuffled(),id: \.self){ item in
                                    NavigationLink {
                                        CommunityPostView(review: post)
                                    } label: {
                                        CommunityListRowView(title:item.title, image: item.thumbnail,community: CustomData.instance.community).padding()
                                        
                                    }
                                    Divider().padding(.horizontal)
                                }
                                .tag(CommunityFilter.free)
                            }.padding(.bottom,40).background(Color.white)
                            ScrollView(showsIndicators: false){
                                ForEach(CustomData.instance.reviewList.shuffled(),id: \.self){ item in
                                    NavigationLink {
                                        CommunityPostView(review: post)
                                    } label: {
                                        CommunityListRowView(title:item.title, image: item.thumbnail,community: CustomData.instance.community).padding()
                                        
                                    }
                                    Divider().padding(.horizontal)
                                }
                                .tag(CommunityFilter.question)
                            }.padding(.bottom,40).background(Color.white)
                            ScrollView(showsIndicators: false){
                                ForEach(CustomData.instance.reviewList.shuffled(),id: \.self){ item in
                                    NavigationLink {
                                        CommunityPostView(review: post)
                                    } label: {
                                        CommunityListRowView(title:item.title, image: item.thumbnail,community: CustomData.instance.community).padding()
                                            
                                    }
                                    Divider().padding(.horizontal)
                                }
                                .tag(CommunityFilter.debate)
                            }.padding(.bottom,40).background(Color.white)
                        }
                        
                        
                        
                    }
                }.ignoresSafeArea()
                .overlay(alignment:.bottomTrailing){
                    Button {
                        search = true
                    } label: {
                        Image("pencil")
                            .resizable()
                            .frame(width: 100,height: 100)
                            
                    }
                    .padding(20)
                    .padding(.bottom,60)
                    .shadow(radius: 10)
                    .navigationDestination(isPresented: $search){
                        MovieListView(title: "검색", writeCommunity: true, back: $search)
                            .navigationBarBackButtonHidden(true)
                    }
                }
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
                    .font(.title2)
                    .bold()
                    .padding(.leading)
                    
                Spacer()
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                    .padding(.trailing)
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
