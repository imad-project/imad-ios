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
                    }
                }else{
                    OnBoardingTabView(isFirstLaunch: $isFirstLaunch)
                }
            }else{
                SplashView()
            }
//            Button {
//               isFirstLaunch = false
//            } label: {
//                Text("asdasdasdads")
//            }

        }.onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeOut(duration: 1.5)){
                    splash = true
                }
            }
            vm.getUser()
            
        }.onReceive(vm.patchInfoSuccess) { value in
            alert = value
            delete = false
        }.onReceive(vm.deleteSuccess){ value in
            alert = value
            delete = true
        }
        .alert(isPresented: $alert) {
            Alert(title:Text("성공!"),dismissButton: delete ? .cancel(Text("확인")):.default(Text("확인")) {
                if !delete{
                    vm.guestMode = false
                }
            })
          
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
