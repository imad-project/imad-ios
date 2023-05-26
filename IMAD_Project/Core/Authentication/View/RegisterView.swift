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
    @EnvironmentObject var vm:AuthViewModel
    @State var success = false
    @Environment(\.dismiss) var dismiss
    
    @State var alertMsg = ""
    @State var notRegex = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            Color.white.ignoresSafeArea()
            BackgroundView(height: 0.33, height1: 0.37,height2: 0.35,height3: 0.36)
            VStack(alignment: .leading){
                Text("회원가입하기")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.customIndigo)
                    .padding(.vertical,20)
                    .frame(maxWidth: .infinity)
                Group{
                    Text("이메일").bold()
                    HStack(alignment: .top){
                        CustomTextField(password: false, image: "envelope.fill", placeholder: "입력", color: Color.gray, text: $email)
                            .keyboardType(.emailAddress)
                            .padding()
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(20)
                            .padding(.bottom)
                            .padding(.horizontal,5)
                        Text("중복확인")
                            .foregroundColor(.white)
                            .padding()
                            .background {
                                Color.customIndigo
                            }
                            .cornerRadius(20)
                    }
                    Text("비밀번호").bold()
                    CustomTextField(password: true, image: "lock", placeholder: "입력", color: Color.gray, text: $password).padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(20)
                        .padding(.horizontal,5)
                        .padding(.bottom,20)
                    Text("비밀번호 확인").bold()
                    CustomTextField(password: true, image: "lock.fill", placeholder: "입력", color: Color.gray, text: $passwordConfirm).padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(20)
                        .padding(.horizontal,5)
                        .padding(.bottom,40)
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
                        return vm.register(email: email, password: password, authProvider: "IMAD") //SHA256
                    }
                }label:{
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 60)
                        .foregroundColor(.customIndigo)
                        .frame(maxWidth: .infinity)
                        .overlay {
                            Text("회원가입")
                                .bold()
                                .foregroundColor(.white)
                                .shadow(radius: 20)
                                
                    
                        }.padding(.horizontal,5)
                }
                .frame(maxWidth: .infinity)
                Spacer()
                
                
                
            }
            .foregroundColor(.customIndigo)
            .padding()
            Image("watch")
                .resizable()
                .frame(width: 150,height: 100)
                .padding()
        }
        .ignoresSafeArea(.keyboard)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .onReceive(vm.registerSuccess) { value in
            notRegex = true
            success = value
            alertMsg = vm.registerRes?.message ?? ""
        }
        .alert(isPresented: $notRegex) {
            Alert(title: Text(success ? "성공":"오류"),message: Text(alertMsg),dismissButton: .default(Text("확인")){
                if success{
                    dismiss()
                }
            })
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
                .environmentObject(AuthViewModel())
        }
        
    }
}


