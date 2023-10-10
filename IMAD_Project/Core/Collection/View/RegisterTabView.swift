//
//  RegisterTabView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/13.
//

import SwiftUI

struct RegisterTabView: View {
    
    @State var phase:CGFloat = 0.0
    @State var phase1:CGFloat = 0.0
    //    @State var tabAnimation = false
    @State var height = [0.23,0.27,0.25,0.26]
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var body: some View {
        ZStack(alignment:.bottomTrailing){
            Color.white.ignoresSafeArea()
            TabView(selection: $vmAuth.selection) {
                NicknameSelectView()
                    .tag(RegisterFilter.nickname)
                    .environmentObject(vmAuth)
                    .ignoresSafeArea()
                GenderSelectView()
                    .tag(RegisterFilter.gender)
                    .environmentObject(vmAuth)
                AgeSelectView()
                    .tag(RegisterFilter.age)
                    .environmentObject(vmAuth)
                SelectGenreView()
                    .tag(RegisterFilter.genre)
                    .environmentObject(vmAuth)
                ProfileSelectView()
                    .tag(RegisterFilter.profile)
                    .environmentObject(vmAuth)
            }
            .ignoresSafeArea()
            .tabViewStyle(.page(indexDisplayMode: .never))
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
            BackgroundView(height: height[0], height1: height[1],height2: height[2],height3: height[3])
            if vmAuth.selection != .genre{
                Image("watch")
                    .resizable()
                    .frame(width: 150,height: 100)
                    .padding()
            }
            
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onAppear{
            vmAuth.selection = .nickname
        }
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .onChange(of: vmAuth.selection) { newValue in
            if newValue == .genre{
                withAnimation(.linear(duration: 1.0)){
                    //                    tabAnimation = true
                    height = [0,0,0,0]
                }
            }else{
                withAnimation(.linear(duration: 1.0)){
                    //                    tabAnimation = false
                    height = [0.23,0.27,0.25,0.26]
                }
            }
        }
        
    }
}

struct RegisterTabView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterTabView().environmentObject(AuthViewModel())
    }
}

