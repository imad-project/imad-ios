//
//  CommunityView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/06.
//

import SwiftUI

struct CommunityView: View {
    @StateObject var vm = CommunityTabViewModel()
    var body: some View {
        ZStack{
            VStack(spacing: 0) {
                Section(header:header){
                    TabView(selection: $vm.communityTab) {
                        Group{
                            List(CustomData.instance.movieList.shuffled(),id: \.self){ item in
                                CommunityListRowView(image: item,community: CustomData.instance.community)
                                    .listRowBackground(Color.white)
                            }
                            .tag(CommunityFilter.free)
                            List(CustomData.instance.movieList.shuffled(),id: \.self){ item in
                                CommunityListRowView(image: item,community: CustomData.instance.community)
                                    .listRowBackground(Color.white)
                            }
                            .tag(CommunityFilter.question)
                            List(CustomData.instance.movieList.shuffled(),id: \.self){ item in
                                CommunityListRowView(image: item,community: CustomData.instance.community)
                                    .listRowBackground(Color.white)
                            }
                            .tag(CommunityFilter.debate)
                        }
                        .background(.white)
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)   //리스트 배경 없음
                        .padding(.bottom,50)
                        
                    }
                    
                }
            }
            .ignoresSafeArea()
            .background{
                LinearGradient(colors: [.black,.customIndigo], startPoint: .top, endPoint: .bottom)
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
        .foregroundColor(.white)
        .padding(.vertical)
        .padding(.top,30)
        .background{
            LinearGradient(colors: [.black,.customIndigo], startPoint: .top, endPoint: .bottom)
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
