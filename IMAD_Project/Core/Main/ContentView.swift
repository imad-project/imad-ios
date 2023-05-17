//
//  ContentView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/03/27.
//

import SwiftUI

struct ContentView: View {
    
    @State var splash = false
    @State var login = false
    @StateObject var vm = AuthViewModel()
    
    var body: some View {
        ZStack {
            if splash{
                if vm.loginMode{
                    if vm.patchInfoSuccess{
                        RegisterTabView()
                    }else{
                        MenuTabView().environmentObject(vm)
                    }
                }else{
                    LoginAllView().environmentObject(vm)
                }
            }else{
                SplashView()
            }
        }.onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeOut(duration: 1.5)){
                    splash = true
                }
            }
            vm.getUser()
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
