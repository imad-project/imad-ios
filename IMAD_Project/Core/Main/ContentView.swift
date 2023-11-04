//
//  ContentView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/03/27.
//

import SwiftUI

struct ContentView: View {
    
    @State var isFirstLaunch = UserDefaults.standard.bool(forKey: "isFirstLaunch") //온보딩

    @State var delete = false
    @State var alert = false
    @State var splash = false
    @State var login = false
    @StateObject var vm = AuthViewModel()
    
    var body: some View {
        ZStack {
            if splash{
                if isFirstLaunch{
                    if vm.loginMode{
                        if vm.guestMode{
                            RegisterTabView().environmentObject(vm)
                        }else{
                            MenuTabView().environmentObject(vm)
                        }
                    }else{
                        LoginAllView().environmentObject(vm)
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

        }.onReceive(vm.patchInfoSuccess) { value in
            withAnimation(.default){
                vm.guestMode = false
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
