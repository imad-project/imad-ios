//
//  ContentView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/03/27.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @State var isFirstLaunch = UserDefaults.standard.bool(forKey: "isFirstLaunch") //온보딩
    @State var flashOn = true
    @StateObject var vmAuth = AuthViewModel(user:nil)
    @StateObject var user = UserInfoManager.instance
    var body: some View {
        ZStack {
            if flashOn{
                SplashView(off: $flashOn)
            }else{
                if isFirstLaunch{
                    if let user = user.cache{
                        if user.role == "GUEST"{
                            UpdateUserProfileView()
                        }else{
                            MenuTabView()
                        }
                    }else{
                        LoginView()
                    }
                }else{
                    OnBoardingTabView(isFirstLaunch: $isFirstLaunch)
                }
            }
        }
        .onAppear{ 
            if user.cache == nil{ vmAuth.getUser() }
            KingfisherManager.shared.cache.memoryStorage.config.totalCostLimit = 200 * 1024 * 1024
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ContentView(vmAuth:AuthViewModel(user: CustomData.user))
        }
    }
}
