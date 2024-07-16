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
                VStack{
                    genderSelectView(gender: "MALE")
                    genderSelectView(gender: "FEMALE")
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
                .font(.GmarketSansTTFMedium(20))
                .bold()
                .padding(.leading)
            Text("설정된 성별 언제든지 바꾸실수 있습니다. ")
                .font(.GmarketSansTTFMedium(15))
                .padding(.leading)
        }
    }
    func genderSelectView(gender:String) -> some View{
       
            Button {
                vm.patchUser.gender = gender
            } label: {
                HStack{
                    Image(gender)
                        .resizable()
                        .frame(width: 20,height: 25)
                    Text(gender == "MALE" ? "남성" : "여성")
                        .fontWeight(vm.patchUser.gender  == gender ? .bold:.none)
                    Spacer()
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            }
            .overlay {
                if vm.patchUser.gender == gender{
                    Color.black.opacity(0.5).cornerRadius(10)
                }
            }
            .padding(.horizontal)
            
    }
}


