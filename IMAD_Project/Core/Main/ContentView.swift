//
//  ContentView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/03/27.
//

import SwiftUI

struct ContentView: View {
    @State var isFirstLaunch = UserDefaults.standard.bool(forKey: "isFirstLaunch") //온보딩
    @State var flashOn = true
    @StateObject var vmAuth = AuthViewModel(user:nil)
    
    var body: some View {
        ZStack {
            if flashOn{
                SplashView(off: $flashOn)
            }else{
                if isFirstLaunch{
                    if var user = vmAuth.user{
//                        Group{
                            if user.role == "GUEST"{
                                RegisterTabView()
                            }else{
                                MenuTabView()
                            }
//                        }
//                        .onChange(of: user){ print($0) }
                    }else{
                        LoginAllView()
                    }
                }else{
                    OnBoardingTabView(isFirstLaunch: $isFirstLaunch)
                }
            }
        }
        .onAppear{ vmAuth.getUser() }
        
        .environmentObject(vmAuth)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ContentView(vmAuth:AuthViewModel(user: CustomData.user))
        }
    }
}
