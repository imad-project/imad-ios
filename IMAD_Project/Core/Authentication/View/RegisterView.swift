//
//  RegisterView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/12.
//

import SwiftUI
import SwiftUIWave

struct RegisterView: View {
    
    @State var email = ""
    @State var password = ""
    @State var passwordConfirm = ""
    
    
    @State var success = false
    @State var notRegex = false
    
    @State var temp = ""
    
    @StateObject var vmCheck = CheckDataViewModel()
    @EnvironmentObject var vm:AuthViewModel
    
    @Environment(\.dismiss) var dismiss
    
    
    @State var domain = EmailFilter.gmail
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            WaveImage(color: .customIndigo, height: .low, speed: .slow, amplitude: .low)
            VStack(alignment: .leading,spacing: 0){
                titleView
                emailView
                duplicationView
                passwordView
                registerButtonView
                Spacer()
            }
            .foregroundColor(.customIndigo)
        }
        .background(.white)
        .ignoresSafeArea(.keyboard)
        .onTapGesture { UIApplication.shared.endEditing() }
        .onReceive(vm.registerSuccess) { value in
            notRegex = true
            success = value
        }
        .alert(isPresented: $notRegex) {
            Alert(title: Text(success ? "성공":"오류"),message: Text(vm.message),dismissButton: .default(Text("확인")){
                if success{
                    vm.selection = .nickname
                    vm.getUser()
                }
            })
        }
    }
    
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            RegisterView()
            
        }
        
    }
}

extension RegisterView{
    var titleView:some View{
        Text("회원가입하기")
            .font(.GmarketSansTTFMedium(25))
            .bold()
            .foregroundColor(.customIndigo)
            .padding(.vertical,30)
            .padding(.bottom,50)
            .frame(maxWidth: .infinity)
    }
    var emailView:some View{
        VStack(alignment: .leading) {
            Text("이메일").font(.GmarketSansTTFMedium(15))
            HStack{
                VStack{
                    CustomTextField(password: false, image: "envelope.fill", placeholder: "입력", color: Color.gray, text: $email)
                        .keyboardType(.emailAddress)
                        .padding(.vertical,3)
                    Divider()
                        .frame(height: 1)
                        .background(Color.customIndigo)
                }
                Text("@")
                    .padding(.leading)
                    .font(.GmarketSansTTFMedium(15))
                Picker("", selection: $domain) {
                    ForEach(EmailFilter.allCases,id:\.self){ item in
                        Text(item.domain)
                    }
                }
                .accentColor(.black)
            }
        }.padding(.leading,15)
    }
    var duplicationView:some View{
        HStack{
            Text(vmCheck.message)
                .foregroundColor(vmCheck.possible ? .green:.red)
                .font(.GmarketSansTTFMedium(12))
            Spacer()
            Button {
                if email != ""{
                    vmCheck.checkEmail(email: "\(email)@\(domain.domain)")
                }else{
                    vmCheck.showMessage(message: "이메일을 제대로 입력해주세요!",possible: false)
                }
                temp = "\(email)@\(domain.domain)"
            } label: {
                Text("중복확인")
                    .cornerRadius(20)
                    .font(.GmarketSansTTFMedium(12))
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.customIndigo)
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal,15)
    }
    var passwordView:some View{
        VStack(alignment: .leading,spacing: 20) {
            Text("비밀번호")
                .font(.GmarketSansTTFMedium(15))
                .padding(.top,5)
            CustomTextField(password: true, image: "lock", placeholder: "입력", color: Color.gray, text: $password)
                .foregroundColor(.customIndigo)
            Divider()
                .frame(height: 1)
                .background(Color.customIndigo)
            Text("비밀번호 확인").font(.GmarketSansTTFMedium(15))
            CustomTextField(password: true, image: "lock.fill", placeholder: "입력", color: Color.gray, text: $passwordConfirm) .foregroundColor(.customIndigo)
            Divider()
                .frame(height: 1)
                .background(Color.customIndigo)
                .padding(.bottom,40)
        }
        .padding(.horizontal,15)
    }
    var registerButtonView:some View{
        CustomConfirmButton(text: "회원가입", color: .customIndigo, textColor: .white) {
            registerCheck()
        }
        
        .padding(.horizontal,15)
    }
    func isVaildInfo()->Int{
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        let passwordRegex = "[A-Za-z0-9!_@$%^&+=]{8,20}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        
        if email.isEmpty || password.isEmpty || passwordConfirm.isEmpty{
            return 1
        }else if !emailPredicate.evaluate(with: "\(email)@\(domain.domain)"){
            return 2
        }else if !passwordPredicate.evaluate(with: password){
            return 3
        }else if password != passwordConfirm{
            return 4
        }else if vmCheck.message == ""{
            return 5
        }else if temp != "\(email)@\(domain.domain)"{
            return 6
        }
        else{
            return 0
        }
    }
    func registerCheck(){
        switch isVaildInfo(){
        case 1:
            vm.message = "입력하지 않은 정보가 있습니다!"
            return notRegex = true
        case 2:
            vm.message = "유효하지 않은 이메일입니다!"
            return notRegex = true
        case 3:
            vm.message = "비밀번호는 영문 대,소문자, 숫자, 특수문자만 허용되며 8~20자 사이여야 합니다!"
            return notRegex = true
        case 4:
            vm.message = "비밀번호가 일치하지 않습니다!"
            return notRegex = true
        case 5:
            vm.message = "이메일 중복확인을 해주세요!"
            return notRegex = true
        case 6:
            vm.message = "이메일이 변경되었습니다. 중복확인을 다시 해주세요!"
            return notRegex = true
        default:
            return vm.register(email: "\(email)@\(domain.domain)", password: password.sha256(), authProvider: "IMAD") //SHA256
        }
    }
}


