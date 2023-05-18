//
//  LogionView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/11.
//

import SwiftUI

struct LoginView: View {
    
    @State var id = ""
    @State var password = ""
    
    @State var success = false
    @State var msg = false
    @State var oauth = false
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm:AuthViewModel
    
    var body: some View{
        ZStack{
            BackgroundView(height: 0.73, height1: 0.77,height2: 0.75,height3: 0.76)
            VStack(alignment: .leading){
                Group{
                    Text("로그인하기")
                        .font(.title)
                        .bold()
                        .foregroundColor(.customIndigo)
                        .padding(.top,50)
                    Spacer()
                    Text("아이디").bold()
                    CustomTextField(password: false, image: "person.fill", placeholder: "입력", color: Color.white, text: $id).padding(.leading)
                        .keyboardType(.emailAddress)
                    Text("비밀번호").bold()
                    CustomTextField(password: true, image: "lock.fill", placeholder: "입력", color: Color.white, text: $password).padding(.leading)
                        .padding(.bottom,50)
                    Button {
                        vm.login(email: id, password: password)
                    } label: {
                        Capsule()
                            .frame(height: 50)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .overlay {
                                Text("로그인")
                                    .bold()
                                    .foregroundColor(.customIndigo)
                                    .shadow(radius: 20)
                                    
                        
                            }.padding(.horizontal)
                    }
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        HStack{
                            Text("SNS로 가입하셨나요?")
                            Text("소셜 로그인")
                                .bold()
                           
                                
                        }.font(.caption)
                    }
                    .frame(maxWidth: .infinity)
                }.padding(10)
                HStack{
                    Text("계정을 잃어버리셨나요?")
                    Text("아이디 찾기").bold()
                    Text("|").bold()
                    Text("비밀번호 찾기").bold()
                }
                .font(.caption)
                .frame(maxWidth: .infinity)
                
            }.foregroundColor(.white)
            
        }
        .ignoresSafeArea(.keyboard)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .onReceive(vm.loginSuccess) { value in
            success = true
            msg = value
        }
        .alert(isPresented: $success) {
            Alert(title: msg ? Text("로그인에 성공했습니다."): Text("로그인에 실패했습니다."),dismissButton: .default(Text("확인")) {
                //print(vm.loginRes?.data?.nickname)
                vm.loginMode = msg
//                if let nickname = vm.loginRes?.data?.nickname,nickname.isEmpty{
//                    print(nickname)
//                    vm.patchInfoSuccess = msg
//                }
            })
        }
    }
}

struct LogionView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}


