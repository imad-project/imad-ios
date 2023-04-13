//
//  RegisterTabView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/13.
//

import SwiftUI

struct RegisterTabView: View {
    @State var selection = 0
    @Binding var register:Bool
    @StateObject var vm = StageTabViewModel()
    var body: some View {
        ZStack(alignment:.bottom){
            TabView(selection: $vm.tab) {
                RegisterGenderView()
                    .tag(RegisterFilter.info)
                SelectGenreView()
                    .tag(RegisterFilter.genre)
                ProfileSelectView(register: $register)
                    .tag(RegisterFilter.photo)
                    .onTapGesture {
                        register = false
                        print("눌림")
                    }
            }.accentColor(.white)
            stage
        }.navigationBarBackButtonHidden(true)
        
    }
}

struct RegisterTabView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterTabView(register: .constant(false))
    }
}
extension RegisterTabView{
    var stage:some View{
        GeometryReader{ geo in
            let width = geo.size.width
            HStack(spacing: 0) {
                ForEach(RegisterFilter.allCases,id:\.self){ tab in
                    Button {
                        withAnimation(.easeIn(duration: 0.2)){
                            vm.tab = tab
                        }
                    } label: {
                        Image(systemName: tab.image)
                            .font(.largeTitle)
                            .frame(maxWidth: .infinity)
                            .background{
                                Circle()
                                    .foregroundColor(.customIndigo)
                                    .frame(width: 20,height: 20)
                            }
                    }.frame(height: 30)
                }
            }
            .background(alignment: .leading){
                Capsule()
                    .frame(height: 5)
                    .foregroundColor(.white)
                    .frame(width: 70 + vm.indicatorOffset(width: width))
                    
            }
        }
        .frame(height: 20)
        .padding(.top,8)
        .padding(.bottom,20)
        .foregroundColor(.white)
        
    }
}
