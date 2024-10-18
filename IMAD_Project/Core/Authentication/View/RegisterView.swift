//
//  RegisterView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/12.
//

import SwiftUI
import SwiftUIWave

struct RegisterView: View {
    
    @State var email = ""                                       //이메일 텍스트
    @State var password = ""                                    //패스워드 텍스트
    @State var passwordConfirm = ""                             //패스워드 확인 텍스트
    @State var isOnAlert = false                                //알림 표시
    @State var registerResult = (success:false,message:"")      //회원가입 성공 유무
    @State var duplicationResult = (possible:false,message:"")  //중복확인 가능 유무
    @State var tempEmail = ""                                   //중복확인 후 이메일 수정을 방지하는 변수
    @State var domain = EmailFilter.gmail                       //이메일 도메인
    
    @Environment(\.dismiss) var dismiss
    @StateObject var vmCheck = CheckDataViewModel()
    @EnvironmentObject var vmAuth:AuthViewModel
    
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
        .onReceive(vmAuth.registerResultEvent){excuteAlert($0)}
        .onReceive(vmCheck.checkResultEvent){excuteDuplication($0)}
        .alert(isPresented: $isOnAlert){ alert }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            RegisterView()
                .environmentObject(AuthViewModel(user: CustomData.user))
        }
    }
}

extension RegisterView{
    var alert:Alert{
        let text = Text(registerResult.success ? "성공":"실패")
        let message = Text(registerResult.message)
        let button = Alert.Button.default(Text("확인")){
            if registerResult.success{
                vmAuth.getUser()
                dismiss()
            }
        }
        return Alert(title: text,message:message,dismissButton:button)
    }
    func excuteAlert(_ event:(Bool,String)){
        registerResult = event
        isOnAlert = true
    }
    func excuteDuplication(_ event:(Bool,String)){
        duplicationResult = event
    }
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
            Text("이메일")
                .font(.GmarketSansTTFMedium(15))
            HStack{
                CustomTextField(password: false, image: "envelope.fill", placeholder: "입력", color: Color.gray, style: .line, text: $email)
                    .keyboardType(.emailAddress)
                    .padding(.vertical,3)
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
        }
        .padding(.leading,15)
    }
    var duplicationView:some View{
        HStack{
            Text(duplicationResult.message)
                .foregroundColor(duplicationResult.possible ? .green:.red)
                .font(.GmarketSansTTFMedium(12))
            Spacer()
            Button {
                duplicationAction()
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
            CustomTextField(password: true, image: "lock", placeholder: "입력", color: Color.gray, style: .line,  text: $password)
            Text("비밀번호 확인").font(.GmarketSansTTFMedium(15))
            CustomTextField(password: true, image: "lock.fill", placeholder: "입력", color: Color.gray, style: .line, text: $passwordConfirm)
        }
        .padding(.top,5)
        .padding(.bottom,40)
        .padding(.horizontal,15)
    }
    var registerButtonView:some View{
        CustomConfirmButton(text: "회원가입", color: .customIndigo, textColor: .white) {
            registerAction()
        }
        .padding(.horizontal,15)
    }
    func isVaildRegisterInfo()->RegisterCheckFilter{
        let passwordRegex = "[A-Za-z0-9!_@$%^&+=]{8,20}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        
        if email.isEmpty || password.isEmpty || passwordConfirm.isEmpty{
            return .emptyInfomation
        }else if !passwordPredicate.evaluate(with: password){
            return .passwordFormatError
        }else if password != passwordConfirm{
            return .passwordMismatch
        }else if duplicationResult.message.isEmpty{
            return .notConfirmDuplicate
        }else if tempEmail != "\(email)@\(domain.domain)"{
            return .changedEmail
        }else{
            return .success
        }
    }
    func isVaildEmailInfo()->EmailCheckFilter{
        let emailRegex = "[A-Z0-9a-z._%+-]{3,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        if email.isEmpty{
            return .emptyInfomation
        }else if !emailPredicate.evaluate(with: email){
            return .emailFormatError
        }else{
            return .success
        }
    }
    func registerAction(){
        switch isVaildRegisterInfo(){
        case .success:
            vmAuth.register(email: "\(email)@\(domain.domain)", password: password.sha256(), authProvider: "IMAD")
        default:excuteAlert((false,isVaildRegisterInfo().message))
        }
    }
    func duplicationAction(){
        switch isVaildEmailInfo(){
        case .success:vmCheck.checkEmail(email: "\(email)@\(domain.domain)")
        default:duplicationResult = (false,isVaildEmailInfo().message)
        }
        tempEmail = "\(email)@\(domain.domain)"
    }
}


