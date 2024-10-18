//
//  AgeSelectView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/26.
//

import SwiftUI

struct AgeSelectView: View {
    @EnvironmentObject var vmAuth:AuthViewModel
    var body: some View {
        VStack(alignment: .leading,spacing: 5){
            guideView
            pickerView
            CustomConfirmButton(text: "다음", color: .customIndigo.opacity(0.5),textColor:.white) {
                withAnimation(.linear){ vmAuth.selection = .genre }
            }
        }
        .padding()
        .background(.white)
        .foregroundColor(.customIndigo)
    }
}

struct AgeSelectView_Previews: PreviewProvider {
    static var previews: some View {
        AgeSelectView()
            .environmentObject(AuthViewModel(user: CustomData.user))
    }
}
extension AgeSelectView{
    var guideView:some View{
        VStack(alignment: .leading,spacing: 5){
            Text("나이를 설정해주세요")
                .font(.GmarketSansTTFMedium(20))
                .bold()
            Text("나이 정보는, 보다 정확하고 맞춤형 작품 추천을 위해 수집함을 안내드립니다.")
                .font(.GmarketSansTTFMedium(15))
        }
    }
    var pickerView:some View{
        HStack{
            Spacer()
            Picker("", selection: $vmAuth.patchUser.age) {
                ForEach(1900...Int().currentDate, id: \.self) {
                    Text("\($0)")
                }
            }
            .pickerStyle(InlinePickerStyle())
            .colorScheme(.light)
            .overlay(alignment:.trailing){
                Text("년").font(.GmarketSansTTFMedium(17)).offset(x:20)
            }
            .frame(width:150,height: 150)
            Spacer()
        }
    }
}
