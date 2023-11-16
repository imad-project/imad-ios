//
//  RegisterGenderView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/12.
//

import SwiftUI

struct GenderSelectView: View {
    

    @EnvironmentObject var vm:AuthViewModel
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading,spacing: 5){
                guideView
                HStack(spacing: 30){
                    genderButtonView(gender: "MALE")
                    genderButtonView(gender: "FEMALE")
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                CustomNextButton(action: {vm.selection = .age}, color: .customIndigo.opacity(0.5))
                    .padding(.bottom,50)
                
                
            }.foregroundColor(.customIndigo).padding()
            
        }
    }
}

struct GenderSelectView_Previews: PreviewProvider {
    static var previews: some View {
        GenderSelectView()
            .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
    }
}
extension GenderSelectView{
    var guideView:some View{
        VStack(alignment: .leading,spacing: 5){
            Text("성별을 설정해주세요")
                .font(.title3)
                .bold()
                .padding(.leading)
            Text("설정된 성별 언제든지 바꾸실수 있습니다. ")
                .font(.callout)
                .padding(.leading)
        }
    }
    func genderButtonView(gender:String) -> some View{
        VStack{
            Button {
                vm.patchUser.gender = gender
            } label: {
                Rectangle()
                    .overlay {
                        Image(gender)
                            .resizable()
                            .frame(width: 80,height: 100)
                        if vm.patchUser.gender == gender{
                            Color.black.opacity(0.5)
                        }
                    }
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .frame(width: 150,height: 150)
                    .padding(10)
                    .shadow(radius: 20)
            }
            Text(gender == "MALE" ? "남성" : "여성")
        }
    }
}


