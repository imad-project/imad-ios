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
    @State var blank = false
    @State var blankColor = false
    @State var blankMsg = ""
    @StateObject var vmCheck = CheckDataViewModel()
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
                
                HStack{
                    CustomTextField(password: false, image: "person", placeholder: "입력..", color: .gray, text: $text)
                        .padding()
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(20)
                        
                    Button {
                        if text != ""{
                            vmCheck.checkNickname(nickname: text)
                        }else{
                            blankMsg = "닉네임을 제대로 입력해주세요!"
                            blankColor = false
                            blank = true
                        }
                    } label: {
                        Text("중복확인")
                            .foregroundColor(.white)
                            .padding()
                            .background {
                                Color.customIndigo
                            }
                            .cornerRadius(20)
                    }
                    
                }
                .padding(.top,20)
                .padding(.horizontal)
                Text(blankMsg)
                    .foregroundColor(blankColor ? .green:.red)
                    .font(.caption)
                    .padding(.horizontal)
                Button {
                    if let cheack = vmCheck.check{
                        if cheack{
                            vm.profileInfo.nickname = text
                            withAnimation(.linear){
                                vm.selection = .gender
                            }
                        }
                    }else{
                        self.blankMsg =  "닉네임 중복확인을 해주세요"
                        blankColor = false
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
                    .padding(.top,20)

                Spacer()
            }.padding()
        }
        .onChange(of: vmCheck.check){ value in
            if let check = value{
                if check{
                    self.blankMsg =  "사용할 수 있는 닉네임입니다!"
                    blankColor = true
                }else{
                    self.blankMsg = "사용 중인 닉네임입니다!"
                    blankColor = false
                }
            }
        }
        .ignoresSafeArea()
        .foregroundColor(.customIndigo)
    }
}

struct NicknameSelectView_Previews: PreviewProvider {
    static var previews: some View {
        NicknameSelectView().environmentObject(AuthViewModel())
    }
}
