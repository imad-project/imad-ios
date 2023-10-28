//
//  MenuTabView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/05.
//

import SwiftUI
import Kingfisher

struct MenuTabView: View {
    
    @StateObject var vm = TabViewModel()
    @EnvironmentObject var vmAuth:AuthViewModel
    
    @State var selectFilter = false //필터 선택
    @State var search = false
    
    var body: some View {
        
        ZStack(alignment: .bottom){
            TabView(selection: $vm.tab){
                MainView(search: $search, filterSelect: $selectFilter)
                    .environmentObject(vmAuth)
                    .tag(Tab.home)
                CommunityView()
                    .environmentObject(vmAuth)
                    .tag(Tab.community)
                ExploreView()
                    .tag(Tab.notification)
                ProfileView()
                    .tag(Tab.profile)
                    .environmentObject(vmAuth)
                
            }
            menu
            if selectFilter{
                filterSelectView
            }
        }
        .onAppear{
            UITabBar.appearance().isHidden = true   //탭바 숨김
        }
    }
}

struct MenuTabView_Previews: PreviewProvider {
    static var previews: some View {
        MenuTabView()
            .environmentObject(AuthViewModel())
    }
}



extension MenuTabView{
    var menu: some View {
        GeometryReader{ geo in
            let width = geo.size.width
            HStack(spacing: 0) {
                ForEach(Tab.allCases,id:\.self){ tab in
                    VStack(spacing: 5){
                        if tab.name != ""{
                            Button {
                                withAnimation(.easeIn(duration: 0.2)){
                                    vm.tab = tab
                                }
                            } label: {
                                Image(systemName: tab.name)
                                    .frame(width: 30,height: 30)
                                   
                            }.frame(height: 30)
                        }else{
                            Button {
                                withAnimation(.easeIn(duration: 0.2)){
                                    vm.tab = tab
                                }
                            } label: {
                                Image("\(ProfileFilter.allCases.first(where: {$0.num == vmAuth.getUserRes?.data?.profileImage ?? 0})?.rawValue ?? "")")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 30,height: 30)
                                    .clipShape(Circle())
                                    
                            }
                            .frame(height: 30)
                        }
                        Text(tab.menu)
                            .font(.caption2)
                        
                    }
                    .padding(.top,10)
                    .frame(maxWidth: .infinity)
                }
            }
            .overlay(alignment:.leading){
                Capsule()
                    .padding(.horizontal,UIScreen.main.bounds.width/11)
                    .frame(width: UIScreen.main.bounds.width/4,height: 3)
//                    .padding(.horizontal,width/8)
                    .padding(.bottom,55)
                    .offset(x:vm.indicatorOffset(width: width))
            }
            
        }
        .foregroundColor(.customIndigo)
        .background {
            Color.white.ignoresSafeArea()
                .shadow(radius: 10)

        }
        .frame(height: 70)
        .shadow(radius: 10)
        .frame(maxHeight: .infinity,alignment: .bottom)
        
    }
    
    var filterSelectView:some View{
        VStack{
            Text("장르")
                .font(.title3)
                .bold().padding(.top,70)
                .padding(.bottom,50)
            ScrollView {
                LazyVStack{
                    ForEach(MovieGenreFilter.allCases,id:\.self){
                        Text($0.name)
                            .padding(10)
                    }
                }
                
            }
            .foregroundColor(.white)
            
            Button {
                withAnimation(.easeIn(duration: 0.05)){
                    selectFilter = false
                }
            } label: {
                Image(systemName: "xmark")
                    .background(Color.white.clipShape(Circle()).frame(width: 50,height: 50).shadow(radius: 10))
                    .padding(.bottom,100)
                    .foregroundColor(.black)
                
            }
            
        }.foregroundColor(.white)
            .ignoresSafeArea()
    }
}


