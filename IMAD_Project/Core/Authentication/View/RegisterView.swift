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
    var body: some View {
        ZStack{
            BackgroundView(height: 0.73, height1: 0.8)
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
                    register = true
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
            }
            .foregroundColor(.white)
            .padding()
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


