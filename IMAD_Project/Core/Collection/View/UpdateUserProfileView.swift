//
//  UpdateUserProfileView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/13.
//

import SwiftUI
import SwiftUIWave
struct UpdateUserProfileView: View {
    
    @EnvironmentObject var vmAuth:AuthViewModel
    @State var constent = true
    
    var body: some View {
        ZStack(alignment:.bottomTrailing){
            TabView(selection: $vmAuth.selection) {
                SelectNicknameView()
                    .tag(RegisterFilter.nickname)
                SelectGenderView()
                    .tag(RegisterFilter.gender)
                SelectAgeView()
                    .tag(RegisterFilter.age)
                SelectGenreView()
                    .tag(RegisterFilter.genre)
                SelectProfileView()
                    .tag(RegisterFilter.profile)
            }
            .ignoresSafeArea()
            .tabViewStyle(.page(indexDisplayMode: .never))
            tabViewbar
            WaveImage(color: .customIndigo, height: .veryLow, speed: .slow, amplitude: .low)
        }
        .environmentObject(vmAuth)
        .background(.white)
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .navigationBarBackButtonHidden(true)
        .onTapGesture { UIApplication.shared.endEditing() }
        .fullScreenCover(isPresented:$constent) { UseConditionView() }
    }
}

struct UpdateUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateUserProfileView()
            .environmentObject(AuthViewModel(user: CustomData.user))
    }
}

extension UpdateUserProfileView{
    var tabViewbar:some View{
        HStack{
            ForEach(RegisterFilter.allCases,id:\.self){ sel in
                let condition = sel == vmAuth.selection
                RoundedRectangle(cornerRadius: condition ? 5:20)
                    .frame(width: condition ? 20 : 10,height: 10)
                    .foregroundColor(.customIndigo.opacity(condition ? 1:0.5))
            }
        }
        .frame(maxHeight: .infinity,alignment: .top)
        .frame(maxWidth: .infinity,alignment: .center)
    }
}
