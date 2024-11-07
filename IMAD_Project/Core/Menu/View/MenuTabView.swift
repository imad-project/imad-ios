//
//  MenuTabView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/05.
//

import SwiftUI
import Kingfisher

struct MenuTabView: View {
    
    @State var tab:TabFilter = .home
    @State var tabInfo:CGFloat = 0
    @StateObject var user = UserInfoManager.instance
    
    var body: some View {
        VStack(spacing: 0){
            TabView(selection: $tab){
                MainView()
                    .tag(TabFilter.home)
                CommunityView()
                    .tag(TabFilter.community)
                SearchView(backMode: true, postingMode: false, back: .constant(false))
                    .tag(TabFilter.notification)
                ProfileView()
                    .tag(TabFilter.profile)
            }
            menu
        }
        .ignoresSafeArea(.keyboard)
        .onAppear{ UITabBar.appearance().isHidden = true } //탭바 숨김
    }
}

struct MenuTabView_Previews: PreviewProvider {
    static var previews: some View {
        MenuTabView()
            .environment(\.colorScheme,.light)
    }
}

extension MenuTabView{
    @MainActor
    var menu: some View {
        HStack{
            ForEach(TabFilter.allCases,id:\.self){ item in
                GeometryReader{ geo in
                    let minX = geo.frame(in: .global).minX
                    let mid = geo.frame(in: .local)
                    Button {
                        withAnimation(.easeIn(duration: 0.2)){
                            tabInfo = minX
                            tab = item
                        }
                    } label: {
                        VStack(spacing: 5) {
                            Group{
                                if !item.name.isEmpty{
                                    Image(systemName: item.name)
                                        .font(.GmarketSansTTFBold(20))
                                }else{
                                    ProfileImageView(imagePath:user.cache?.profileImage ?? "",widthHeigt: 30)
                                        .padding(.top,5)
                                }
                            }
                            .position(x:mid.midX,y:mid.midY-15)
                            Text(item.menu)
                                .font(.GmarketSansTTFMedium(10))
                        }
                        .padding(.top)
                    }
                    .onAppear{
                        if item == tab{ self.tabInfo = minX }
                    }
                }
                .frame(width: 50,height: 70)
                .frame(maxWidth: .infinity)
            }
        }
        .foregroundColor(.customIndigo)
        .overlay(alignment:.leading){
            Capsule()
                .frame(width: 50,height: 3)
                .offset(x:tabInfo,y:-35)
        }
    }
}


