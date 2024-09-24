//
//  ContentView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/03/27.
//

import SwiftUI

struct ContentView: View {
    
    @State var isFirstLaunch = UserDefaults.standard.bool(forKey: "isFirstLaunch") //온보딩

    @State var splash = false
    @StateObject var vm = AuthViewModel(user: nil)
    
    var body: some View {
        ZStack {
            if splash{
                if isFirstLaunch{
                    if let user = vm.user?.data{
                        if user.role == "GUEST"{
                            RegisterTabView().environmentObject(vm)
                        }else{ 
                            MenuTabView().environmentObject(vm)
                        }
                    }else{
                        LoginAllView()
                           .environmentObject(vm)
                           .ignoresSafeArea(.keyboard)
                    }
                }else{
                    OnBoardingTabView(isFirstLaunch: $isFirstLaunch)
                }
            }else{
                SplashView()
            }
        }
        .onAppear{
            vm.getUser()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeOut(duration: 1.5)){
                    splash = true
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ContentView()
        }
    }
}
