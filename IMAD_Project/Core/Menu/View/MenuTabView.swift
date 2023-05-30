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
        
        ZStack{
            ZStack(alignment: .bottom){
                TabView(selection: $vm.tab){
                    MainView(search: $search, filterSelect: $selectFilter)
                        .tag(Tab.home)
                    CommunityView()
                        .tag(Tab.community)
                    NotificationView()
                        .tag(Tab.notification)
                    ProfileView()
                        .tag(Tab.profile)
                        .environmentObject(vmAuth)
                    
                }
                menu
            }
            .padding(.bottom,30)
            .ignoresSafeArea()
            .blur(radius: selectFilter ? 20:0, opaque: false) //블러처리
            .allowsHitTesting(selectFilter ? false : true)  //터치 비활성화
            if selectFilter{
                Color.black.opacity(0.7).ignoresSafeArea()
                filterSelectView
            }
        }
        .onAppear{
            UITabBar.appearance().isHidden = true   //탭바 숨김
        }
        .navigationDestination(isPresented: $search) {
            MovieListView(title: "검색", back: $search)
                .navigationBarBackButtonHidden(true)
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
                    VStack{
                        if tab.name != ""{
                            Button {
                                withAnimation(.easeIn(duration: 0.2)){
                                    vm.tab = tab
                                }
                            } label: {
                                Image(systemName: tab.name)
                                    .font(.title2)
                                    .frame(maxWidth: .infinity)
                            }.frame(height: 30)
                        }else{
                            Button {
                                withAnimation(.easeIn(duration: 0.2)){
                                    vm.tab = tab
                                }
                            } label: {
                                ZStack{
                                    Circle()
                                        .frame(width: 30,height: 30)
                                        .foregroundColor(.white)
                                    ForEach(ProfileFilter.allCases,id:\.self){ image in
                                        if let profile = vmAuth.getUserRes?.data?.profileImage, image.num == profile {
                                            Image("\(image)")
                                                .resizable()
                                                .frame(width: 30,height: 30)
                                                .clipShape(Circle()).frame(maxWidth: .infinity)
                                        }
                                    }
                                    Image(vmAuth.getUserRes?.data?.gender ?? "")
                                        .resizable()
                                        .frame(width: 20,height: 15)
                                }
                            }
                            .frame(height: 30)
                        }
                        Text(tab.menu)
                            .font(.caption)
                        
                    }
                    
                }
            }
            .frame(maxWidth:.infinity)
            .overlay(alignment:.leading){
                Capsule()
                    .frame(width: 30,height: 3)
                    .padding(.leading,35)
                    .padding(.bottom,65)
                    .offset(x:vm.indicatorOffset(width: width)+3)
            }
            
        }
        .frame(height: 20)
        .padding(.top,8)
        .padding(.bottom,25)
        .background {
            Color.clear
                .background(.ultraThinMaterial)
                .environment(\.colorScheme, .dark)
            
        }
        .background(Color.black.opacity(0.6))
        .background(Color.indigo.opacity(0.6))
        .foregroundColor(.white)
        
        
        
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
                        Text($0.generName)
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


