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
    
    @State var search = false
    
    var body: some View {
        
        VStack(spacing: 0){
            TabView(selection: $vm.tab){
                MainView(search: $search)
                    .environmentObject(vmAuth)
                    .tag(Tab.home)
                CommunityView()
                    .environmentObject(vmAuth)
                    .tag(Tab.community)
                SearchView(backMode: true, postingMode: false, back: .constant(false))
                    .tag(Tab.notification)
                ProfileView()
                    .tag(Tab.profile)
                    .environmentObject(vmAuth)
                
            }
            menu
        }
        .ignoresSafeArea(.keyboard)
        .onAppear{
            UITabBar.appearance().isHidden = true   //탭바 숨김
        }
    }
}

struct MenuTabView_Previews: PreviewProvider {
    static var previews: some View {
        MenuTabView()
            .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
    }
}



extension MenuTabView{
    var menu: some View {
        GeometryReader{ geo in
            let width = geo.size.width
            HStack(spacing: 0) {
                ForEach(Tab.allCases,id:\.self){ tab in
                    Button {
                        withAnimation(.easeIn(duration: 0.2)){
                            vm.tab = tab
                        }
                    } label: {
                        VStack(spacing: 5) {
                            if tab.name != ""{
                                Image(systemName: tab.name)
                                    .frame(width: 30,height: 30)
                            }else{
                                ProfileImageView(imageCode: vmAuth.user?.data?.profileImage ?? 0,widthHeigt: 25)
                                    .padding(.top,5)
                                    
                            }
                            Text(tab.menu)
                                .font(.caption2)
                        }
                    }
                    .frame(height: 30)
                    .padding(.top,25)
                    .frame(maxWidth: .infinity)
                    
                }
            }
            .overlay(alignment:.leading){
                Capsule()
                    .padding(.horizontal,UIScreen.main.bounds.width/11)
                    .frame(width: UIScreen.main.bounds.width/4,height: 3)
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
        
    }
}


