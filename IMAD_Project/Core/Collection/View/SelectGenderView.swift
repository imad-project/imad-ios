//
//  RegisterGenderView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/12.
//

import SwiftUI

struct SelectGenderView: View {
    
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var body: some View {
        VStack(alignment: .leading,spacing: 5){
            guideView
            VStack{
                SelectGenderView(gender: "MALE")
                SelectGenderView(gender: "FEMALE")
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical)
            CustomConfirmButton(text: "다음", color: .customIndigo.opacity(0.5),textColor:.white){ nextAction(false) }
            .padding(.bottom,50)
        }
        .alert(isPresented: $vmAuth.check.gender){alert}
        .foregroundColor(.customIndigo).padding()
        .background(.white)
        .onDisappear{ nextAction(true) }
    }
}

struct SelectGenderView_Previews: PreviewProvider {
    static var previews: some View {
        SelectGenderView()
            .environmentObject(AuthViewModel(user: CustomData.user))
    }
}
extension SelectGenderView{
    var alert:Alert{
        let title = Text("성별을 제대로 설정 해주세요!")
        let button = Alert.Button.cancel(Text("확인"), action: { withAnimation(.linear){ vmAuth.selection = .gender }})
        return Alert(title: title,dismissButton: button)
    }
    var guideView:some View{
        VStack(alignment: .leading,spacing: 5){
            Text("성별을 설정해주세요")
                .font(.GmarketSansTTFMedium(20))
                .bold()
            Text("성별 정보는, 보다 정확하고 맞춤형 작품 추천을 위해 수집함을 안내드립니다.")
                .font(.GmarketSansTTFMedium(15))
        }
    }
    func SelectGenderView(gender:String) -> some View{
        Button {
            vmAuth.patchUser.gender = gender
            vmAuth.check.gender = false
        } label: {
            HStack{
                Image(gender)
                    .resizable()
                    .frame(width: 20,height: 25)
                Text(gender == "MALE" ? "남성" : "여성")
                    .fontWeight(vmAuth.patchUser.gender  == gender ? .bold:.none)
                Spacer()
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
        }
        .overlay {
            if vmAuth.patchUser.gender == gender{
                Color.black.opacity(0.5).cornerRadius(10)
            }
        }
    }
    func nextAction(_ isSlide:Bool){
        if isSlide{
            if vmAuth.selection == .age{
                if vmAuth.patchUser.gender.isEmpty{
                    vmAuth.check.gender = true
                }else{
                    withAnimation(.linear){
                        vmAuth.selection = .age
                    }
                }
            }
        }else{
            if !vmAuth.patchUser.gender.isEmpty{
                withAnimation(.linear){
                    vmAuth.selection = .age
                }
            }else{
                vmAuth.check.gender = true
            }
        }
    }
}


