//
//  RegisterView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/12.
//

import SwiftUI

struct RegisterView: View {
    
    
    @State var phase:CGFloat = 0.0
    @State var id = ""
    @State var email = ""
    @State var password = ""
    @State var passwordConfirm = ""
    @State var register = false
    @Binding var login:Bool
    @StateObject var vm = AuthViewModel()
    @State var success = false
    @State var msg = false
    
    var body: some View {
        ZStack{
            BackgroundView(height: 0.73, height1: 0.77,height2: 0.75,height3: 0.76)
            VStack(alignment: .leading,spacing: 30){
                Text("회원가입하기")
                    .font(.title)
                    .bold()
                    .foregroundColor(.customIndigo)
                    .padding(.top,50)
                Spacer()
                Group{
                    Text("이메일").bold()
                    CustomTextField(password: false, image: "envelope.fill", placeholder: "입력", color: Color.white, text: $email).padding(.leading)
                    Text("아이디").bold()
                    CustomTextField(password: false, image: "person.fill", placeholder: "입력", color: Color.white, text: $id).padding(.leading)
                    Text("비밀번호").bold()
                    CustomTextField(password: true, image: "lock", placeholder: "입력", color: Color.white, text: $password).padding(.leading)
                    Text("비밀번호 확인").bold()
                    CustomTextField(password: true, image: "lock.fill", placeholder: "입력", color: Color.white, text: $passwordConfirm).padding(.leading)
                        .padding(.bottom,50)
                }
                
                //button(action: register = true, view: Text("회원가입"), buttonColor: .white, textColor: .customIndigo)
                Button{
                    vm.register(email: email, nickname: id, password: password, authProvider: "IMAD")
                    
                }label:{
                    Capsule()
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .overlay {
                            Text("회원가입")
                                .bold()
                                .foregroundColor(.customIndigo)
                                .shadow(radius: 20)
                        }
                }
                .frame(maxWidth: .infinity)
                .navigationDestination(isPresented: $register) {
                    RegisterTabView(register: $login)
                }
                Spacer()
                
                HStack{
                    Text("계정이 있으신가요?")
                    Text("로그인")
                        .bold()
                }
                .font(.caption)
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    withAnimation {
                        login.toggle()
                    }
                }
                .onReceive(vm.registerSuccess) { value in
                    success = true
                    msg = value
                }
                .alert(isPresented: $success) {
                    Alert(title: Text(vm.registerRes?.message ?? ""),dismissButton: .default(Text("확인")) {
                        register = msg
                    })
                }
            }.ignoresSafeArea(.keyboard)
            .foregroundColor(.white)
            .padding()
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            
            RegisterView(login: .constant(true))
        }
        
    }
}


