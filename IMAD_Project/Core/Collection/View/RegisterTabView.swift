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
    
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var body: some View {
        ZStack(alignment:.bottomTrailing){
            
            TabView(selection: $vmAuth.selection) {
                NicknameSelectView()
                    .tag(0)
                    .environmentObject(vmAuth)
                GenderSelectView()
                    .tag(1)
                    .environmentObject(vmAuth)
                AgeSelectView()
                    .tag(2)
                    .environmentObject(vmAuth)
                ProfileSelectView()
                    .tag(3)
                    .environmentObject(vmAuth)
            }.accentColor(.white)
                .tabViewStyle(.page(indexDisplayMode: .never))
                .ignoresSafeArea()
                .background()
            HStack{
                ForEach(0...3,id:\.self){ sel in
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
            BackgroundView(height: 0.23, height1: 0.27,height2: 0.25,height3: 0.26)
            Image("watch")
                .resizable()
                .frame(width: 150,height: 100)
                .padding()
            //stage
        }
        
        .navigationBarBackButtonHidden(true)
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            
    }
}

struct RegisterTabView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterTabView().environmentObject(AuthViewModel())
    }
}
extension RegisterTabView{
    var stage:some View{
        
        Text("")
        
    }
    var background:some View{
        ZStack(alignment: .bottomTrailing){
            Wave(reverse: true, progress: 0.33, addX: 0.2, phase: phase).fill(LinearGradient(colors: [Color.customIndigo.opacity(0.3),Color.customIndigo], startPoint: .top, endPoint: .bottom))
                .onAppear{
                    withAnimation(.linear(duration: 3).repeatForever(autoreverses:false)){
                        self.phase = .pi * 2
                    }
                }
                .ignoresSafeArea()
            Wave(reverse: true, progress: 0.35, addX: 0.4, phase: phase).fill(Color.customIndigo.opacity(0.3))
                .onAppear{
                    withAnimation(.linear(duration: 3).repeatForever(autoreverses:false)){
                        self.phase = .pi * 2
                    }
                }
                .ignoresSafeArea()
            Wave(reverse: false, progress: 0.37, addX: 0.4, phase: phase).fill(Color.customIndigo.opacity(0.3))
                .onAppear{
                    withAnimation(.linear(duration: 3).repeatForever(autoreverses:false)){
                        self.phase = .pi * 2
                    }
                }
                .ignoresSafeArea()
            Wave(reverse: false, progress: 0.36, addX: 0.5, phase: phase).fill(Color.customIndigo.opacity(0.3))
                .shadow(radius: 20)
                .onAppear{
                    withAnimation(.linear(duration: 3).repeatForever(autoreverses:false)){
                        self.phase1 = .pi * 2
                    }
                }
                .ignoresSafeArea()
            
        }
    }
}
