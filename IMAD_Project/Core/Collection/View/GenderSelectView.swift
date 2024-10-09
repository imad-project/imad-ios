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
                CustomConfirmButton(text: "다음", color: .customIndigo.opacity(0.5),textColor:.white) {
                    withAnimation(.linear){
                        vm.selection = .age
                    }
                }
                .padding(.bottom,50)
                
                
            }.foregroundColor(.customIndigo).padding()
            
        }
    }
}

struct GenderSelectView_Previews: PreviewProvider {
    static var previews: some View {
        GenderSelectView()
            .environmentObject(AuthViewModel())
    }
}
extension GenderSelectView{
    var guideView:some View{
        VStack(alignment: .leading,spacing: 5){
            Text("성별을 설정해주세요")
                .font(.GmarketSansTTFMedium(20))
                .bold()
            Text("성별 정보는, 보다 정확하고 맞춤형 작품 추천을 위해 수집함을 안내드립니다.")
                .font(.GmarketSansTTFMedium(15))
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
            
    }
}


