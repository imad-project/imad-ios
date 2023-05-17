//
//  RegisterView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/12.
//

import SwiftUI

struct RegisterView: View {
    
    
    @State var phase:CGFloat = 0.0
    @State var email = ""
    @State var password = ""
    @State var passwordConfirm = ""
    @State var register = false
    @Binding var login:Bool
    @StateObject var vm = AuthViewModel()
    @State var success = false
    @State var msg = false
    
    @State var alertMsg = ""
    @State var notRegex = false
    
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
                    Text("비밀번호").bold()
                    CustomTextField(password: true, image: "lock", placeholder: "입력", color: Color.white, text: $password).padding(.leading)
                    Text("비밀번호 확인").bold()
                    CustomTextField(password: true, image: "lock.fill", placeholder: "입력", color: Color.white, text: $passwordConfirm).padding(.leading)
                        .padding(.bottom,50)
                }
                Button{
                    switch isVaildInfo(){
                    case 1:
                        alertMsg = "입력하지 않은 정보가 있습니다!"
                        return notRegex = true
                    case 2:
                        alertMsg = "유효하지 않은 이메일입니다!"
                        return notRegex = true
                    case 3:
                        alertMsg = "비밀번호는 영문 대,소문자, 숫자, 특수문자만 허용되며 8~20자 사이여야 합니다!"
                        return notRegex = true
                    case 4:
                        alertMsg = "비밀번호가 일치하지 않습니다!"
                        return notRegex = true
                    default:
                        return vm.register(email: email, password: password, authProvider: "IMAD")
                    }
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
        .alert(isPresented: $notRegex) {
            Alert(title: Text("오류"),message: Text(alertMsg),dismissButton: .default(Text("확인")))
        }
    }
    func isVaildInfo()->Int{
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        let passwordRegex = "[A-Za-z0-9!_@$%^&+=]{8,20}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        
        if email.isEmpty || password.isEmpty || passwordConfirm.isEmpty{
            return 1
        }else if !emailPredicate.evaluate(with: email){
            return 2
        }else if !passwordPredicate.evaluate(with: password){
            return 3
        }else if password != passwordConfirm{
            return 4
        }else{
            return 0
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


