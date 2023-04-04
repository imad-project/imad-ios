//
//  ContentView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/03/27.
//

import SwiftUI

struct ContentView: View {
    
    @State var splash = false
    
    var body: some View {
        ZStack {
            if splash{
                Text("메인화면")
            }else{
                SplashView()
            }
        }.onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.easeOut(duration: 1.0)){
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
