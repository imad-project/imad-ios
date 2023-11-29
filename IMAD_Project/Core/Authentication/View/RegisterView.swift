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
    

    @Binding var login:Bool
    @StateObject var vmCheck = CheckDataViewModel()
    @EnvironmentObject var vm:AuthViewModel
    
    @Environment(\.dismiss) var dismiss
    

    @State var domain = EmailFilter.gmail
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            Color.white.ignoresSafeArea()
            WaveImage(color: .customIndigo, height: .low, speed: .slow, amplitude: .low)
            VStack(alignment: .leading){
                Text("회원가입하기")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.customIndigo)
                    .padding(.vertical,20)
                    .frame(maxWidth: .infinity)
                Group{
                   emailView
                   duplicationView
                    passwordView
                }.padding(.horizontal)
                    .padding(.vertical,5)
                registerButtonView
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
        }

        .alert(isPresented: $notRegex) {
            Alert(title: Text(success ? "성공":"오류"),message: Text(vm.message),dismissButton: .default(Text("확인")){
                if success{
                    vm.login(email: "\(email)@\(domain.domain)", password: password)
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
        }else if !emailPredicate.evaluate(with: "\(email)@\(domain.domain)"){
            print("\(email)@\(domain.domain)")
            return 2
        }else if !passwordPredicate.evaluate(with: password){
            return 3
        }else if password != passwordConfirm{
            return 4
        }else if vmCheck.message == ""{
            return 5
        }else{
            return 0
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            RegisterView(login: .constant(true))
                .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
        }
        
    }
}

extension RegisterView{
    var emailView:some View{
        VStack(alignment: .leading) {
            Text("이메일").bold()
            HStack(alignment: .top){
                VStack{
                    CustomTextField(password: false, image: "envelope.fill", placeholder: "입력", color: Color.gray, text: $email)
                        .keyboardType(.emailAddress)
                        .padding(.vertical,5)
                        Divider()
                        .frame(height: 1)
                        .background(Color.customIndigo)
                }
                Text("@").padding(.leading).foregroundColor(.gray)
                Picker("", selection: $domain) {
                    ForEach(EmailFilter.allCases,id:\.self){ item in
                        Text(item.domain)
                    }
                }.accentColor(.black)
                    .frame(maxWidth: .infinity)
            }
        }
    }
    var duplicationView:some View{
        HStack(alignment: .top){
            Text(vmCheck.message)
                .foregroundColor(vmCheck.possible ? .green:.red)
                .font(.caption)
                .padding(.horizontal,5)
            Spacer()
            Button {
                if email != ""{
                    vmCheck.checkEmail(email: "\(email)@\(domain.domain)")
                }else{
                    vmCheck.showMessage(message: "이메일을 제대로 입력해주세요!",possible: false)
                }
            } label: {
                Text("중복확인")
                    .cornerRadius(20)
                    .font(.caption)
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.customIndigo)
                    .cornerRadius(10)
            }
            
        }.padding(.horizontal,5)
    }
    var passwordView:some View{
        VStack(alignment: .leading,spacing: 20) {
            Text("비밀번호").bold()
                .padding(.top,5)
            CustomTextField(password: true, image: "lock", placeholder: "입력", color: Color.gray, text: $password)
               .foregroundColor(.customIndigo)
            Divider()
            .frame(height: 1)
            .background(Color.customIndigo)
            Text("비밀번호 확인").bold()
            CustomTextField(password: true, image: "lock.fill", placeholder: "입력", color: Color.gray, text: $passwordConfirm) .foregroundColor(.customIndigo)
            Divider()
            .frame(height: 1)
            .background(Color.customIndigo)
            .padding(.bottom,40)
        }
    }
    var registerButtonView:some View{
        Button{
           registerCheck()
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
        default:
            return vm.register(email: "\(email)@\(domain.domain)", password: password, authProvider: "IMAD") //SHA256
        }
    }
}


