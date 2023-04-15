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
    
    var body: some View {
        ZStack {
            if splash{
                if login{
                    MenuTabView(login: $login)
                }else{
                    LogionView(login: $login)
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
