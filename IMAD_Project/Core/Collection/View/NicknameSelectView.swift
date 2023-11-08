//
//  ProfileSelectView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/12.
//

import SwiftUI
import PhotosUI

struct NicknameSelectView: View {
    
//    @State var text = ""
    @StateObject var vmCheck = CheckDataViewModel()
    @EnvironmentObject var vm:AuthViewModel
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading){
                Spacer()
                guideView
                checkEmailView
                CustomNextButton(action: {
                    if vmCheck.possible{
                        withAnimation(.linear){
                            vm.selection = .gender
                        }
                    }else{
                        vmCheck.showMessage(message: "닉네임 중복확인을 해주세요", possible: false)
                    }
                }, color: .customIndigo.opacity(0.5))
                    .padding(.bottom,50)
                    .padding(.top,20)
                
                Spacer()
            }.padding()
        }
        
        //        .onReceive(vmCheck.tokenExpired) { messages in
        //            tokenExpired = (true,messages)
        //        }
        //        .alert(isPresented: $tokenExpired.0) {
        //            Alert(title: Text("토큰 만료됨"),message: Text(tokenExpired.1),dismissButton:.cancel(Text("확인")){
        ////                vm.loginMode = false
        //            })
        //        }
        .ignoresSafeArea()
        .foregroundColor(.customIndigo)
    }
}

struct NicknameSelectView_Previews: PreviewProvider {
    static var previews: some View {
        NicknameSelectView().environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
    }
}

extension NicknameSelectView{
    var guideView:some View{
        VStack(alignment: .leading,spacing: 5){
            Text("닉네임을 설정해주세요")
                .font(.title3)
                .bold()
            Text("설정된 닉네임 언제든지 바꾸실수 있습니다. ")
                .font(.callout)
        }
        .padding(.leading)
    }
    var checkEmailView:some View{
        VStack(alignment: .leading){
            HStack{
                CustomTextField(password: false, image: "person", placeholder: "입력..", color: .gray, text: $vm.patchUser.nickname)
                    .padding()
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(20)
                Button {
                    if vm.patchUser.nickname != ""{
                        vmCheck.checkNickname(nickname: vm.patchUser.nickname)
                    }else{
                        vmCheck.showMessage(message: "닉네임을 제대로 입력해주세요!",possible: false)
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
            Text(vmCheck.message)
                .foregroundColor(vmCheck.possible ? .green : .red)
                .font(.caption)
                .padding(.horizontal)
        }
        
    }
    
}
