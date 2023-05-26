//
//  ProfileSelectView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/12.
//

import SwiftUI
import PhotosUI

struct NicknameSelectView: View {
    
    @State var text = ""
   
    
    @EnvironmentObject var vm:AuthViewModel
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading,spacing: 5){
                Spacer()
                Text("닉네임을 설정해주세요")
                    .font(.title3)
                    .bold()
                    .padding(.leading)
                Text("설정된 닉네임 언제든지 바꾸실수 있습니다. ")
                    .font(.callout)
                .padding(.leading)
                
                CustomTextField(password: false, image: "person", placeholder: "입력..", color: .gray, text: $text)
                    .padding()
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .padding(.vertical,20)
                Button {
                    vm.nickname = text
                    withAnimation(.linear){
                        vm.selection = 1
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 60)
                        .foregroundColor(.customIndigo.opacity(0.5))
                        .overlay {
                            Text("다음")
                                .bold()
                                .foregroundColor(.white)
                                .shadow(radius: 20)
                        }
                }.padding(.horizontal)
                    .padding(.bottom,50)

                Spacer()
            }.ignoresSafeArea(.keyboard)
        }
        .foregroundColor(.customIndigo).padding()
    }
}

struct NicknameSelectView_Previews: PreviewProvider {
    static var previews: some View {
        NicknameSelectView().environmentObject(AuthViewModel())
    }
}
