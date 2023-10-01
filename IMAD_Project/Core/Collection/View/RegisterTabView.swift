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
    @State var tabAnimation = false
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
                    .background{
                        if tabAnimation{
                            BackgroundView(height: 0.83, height1: 0.87,height2: 0.85,height3: 0.86)
                        }
                    }
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
            if !tabAnimation{
                BackgroundView(height: 0.23, height1: 0.27,height2: 0.25,height3: 0.26)
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
                withAnimation(.linear(duration: 0.5)){
                    tabAnimation = true
                }
            }else{
                withAnimation(.linear(duration: 0.5)){
                    tabAnimation = false
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

