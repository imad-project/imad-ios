//
//  RegisterTabView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/13.
//

import SwiftUI
import SwiftUIWave
struct RegisterTabView: View {
    
    @StateObject var vmAuth = AuthViewModel()
    @State var constent = true
    
    
    var body: some View {
        ZStack(alignment:.bottomTrailing){
            Color.white.ignoresSafeArea()
            TabView(selection: $vmAuth.selection) {
                NicknameSelectView()
                    .tag(RegisterFilter.nickname)
                   
                    .ignoresSafeArea()
                GenderSelectView()
                    .tag(RegisterFilter.gender)
                   
                AgeSelectView()
                    .tag(RegisterFilter.age)
                   
                SelectGenreView()
                    .tag(RegisterFilter.genre)
                   
                ProfileSelectView()
                    .tag(RegisterFilter.profile)
                   
            }
            .ignoresSafeArea()
            .tabViewStyle(.page(indexDisplayMode: .never))
            tabViewbar
            WaveImage(color: .customIndigo, height: .veryLow, speed: .slow, amplitude: .low)
            
            
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .fullScreenCover(isPresented:$constent) {
            UseConditionView()
        }
    }
}

struct RegisterTabView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterTabView()
        .environmentObject(AuthViewModel())
    }
}

extension RegisterTabView{
    var tabViewbar:some View{
        HStack{
            ForEach(RegisterFilter.allCases,id:\.self){ sel in
                if sel == vmAuth.selection{
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 20,height: 10)
                        .foregroundColor(.customIndigo)
                }else{
                    Circle()
                        .frame(width: 10,height: 10)
                        .foregroundColor(.black.opacity(0.2))
                }
            }
        }
        .frame(maxHeight: .infinity,alignment: .top)
        .frame(maxWidth: .infinity,alignment: .center)
    }
}
