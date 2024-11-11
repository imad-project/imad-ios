//
//  LoginView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/16.
//

import SwiftUI
import Alamofire
import AuthenticationServices

struct LoginView: View{

    @State var isOnAlert = false                    //알림 표시
    @State var alertMessage = ""                    //알림에 표시될 메세지
    @State var loginFailed = false                  //로그인 실패 시
    @State var loginFilter:OauthCategory? = nil      //로그인 및 회원가입 필터
    @State var email = ""                           //이메일 텍스트
    @State var password = ""                        //패스워트 텍스트
    @State var domain = EmailDomainCategory.gmail           //이메일 도메인
    @State var loading = false                      //로딩 유무
    @StateObject var vmAuth = AuthViewModel(user: nil)
    
    var body: some View {
        ScrollView(showsIndicators:false){
            VStack(spacing: 0){
                titleView
                VStack(alignment: .leading){
                    emailView
                    passwordView
                    authView
                }
                .padding(.vertical)
                .padding(10)
                divderView
                loginButtonView
            }
        }
        .backgroundColor{Color.white.onTapGesture { UIApplication.shared.endEditing() }}
        .progress(!loading)
        .onReceive(vmAuth.loginSuccess){ excuteAlert(true, $0)}             //로그인 성공 시
        .onChange(of:loginFailed){ excuteAlert($0, "로그인이 실패했습니다.") }    //소셜 로그인 실패 시
        .alert(isPresented: $isOnAlert){ alert }                            //로그인 성패 알림
        .sheet(item: $loginFilter) { filter in
            if filter == .none{
                RegisterView()
            }else{
                AuthWebView(filter: filter,failed: $loginFailed)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            LoginView(vmAuth:AuthViewModel(user: CustomData.user))
        }
    }
}

extension LoginView{
    func excuteAlert(_ isOnAlert:Bool,_ message:String){
        self.isOnAlert = isOnAlert
        self.alertMessage = message
    }
    var alert:Alert{
        let text = Text(alertMessage)
        let button = Alert.Button.cancel(Text("확인")){ loading = false }
        return Alert(title:text,dismissButton:button)
    }
    var titleView:some View{
        Text("환영합니다")
            .font(.GmarketSansTTFMedium(30))
            .bold()
            .foregroundColor(.customIndigo)
            .padding(.top,20)
            .frame(maxWidth: .infinity)
            .padding(.bottom,50)
    }
    var emailView:some View{
        VStack(alignment: .leading,spacing:5){
            Text("이메일")
                .font(.GmarketSansTTFMedium(15))
                .foregroundColor(.customIndigo)
            HStack{
                CustomTextField(password: false, image: "person.fill", placeholder: "입력..", color: Color.gray,style: .line, text: $email)
                    .keyboardType(.emailAddress)
                    .padding(.vertical,5)
                Text("@").padding(.leading)
                Picker("", selection: $domain) {
                    ForEach(EmailDomainCategory.allCases,id:\.self){ item in
                        Text(item.domain)
                    }
                }
                .accentColor(.black)
                .frame(maxWidth: .infinity)
            }
            .padding(.leading)
            .padding(.bottom,5)
        }
    }
    var passwordView:some View{
        VStack(alignment: .leading) {
            Text("비밀번호")
                .font(.GmarketSansTTFMedium(15))
                .foregroundColor(.customIndigo)
            CustomTextField(password: true, image: "lock.fill", placeholder: "입력..",color: Color.gray, style:.line, text: $password)
                .padding(.horizontal)
                .padding(.vertical,20)
        }
    }
    var authView:some View{
        VStack{
            CustomConfirmButton(text: "로그인", color: .customIndigo, textColor: .white) {
                vmAuth.login(email: "\(email)@\(domain.domain)", password: password.sha256())
                loading = true
            }
            CustomConfirmButton(text: "회원가입", color: .customIndigo.opacity(0.5), textColor: .white) {
                loginFilter = OauthCategory.none
            }
        }
    }
    var divderView:some View{
        HStack{
            VStack{
                Divider()
                    .frame(height: 1)
                    .background(Color.customIndigo)
            }
            Text("소셜 로그인")
                .padding()
                .font(.GmarketSansTTFMedium(12))
                .foregroundColor(.customIndigo)
            VStack{
                Divider()
                    .frame(height: 1)
                    .background(Color.customIndigo)
            }
        }
        .padding(.horizontal)
        .padding(.top,50)
    }
    var loginButtonView:some View{
        VStack{
            appleLoginButton
                .overlay {
                    loginButton(item: .Apple)
                        .allowsHitTesting(false)
                }
            ForEach(OauthCategory.allCases.filter{$0 != .Apple && $0 != .none},id:\.rawValue){ item in
                Button {
                    loginFilter = item
                } label: {
                    loginButton(item: item)
                }
                .shadow(color:.gray.opacity(0.3),radius: 3)
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
    var appleLoginButton:some View{
        SignInWithAppleButton {
            $0.requestedScopes = [.fullName, .email,]
        } onCompletion: { vmAuth.appleLogin(result: $0) }
        .frame(height:50)
        .cornerRadius(10)
    }
    func loginButton(item:OauthCategory) -> some View{
        RoundedRectangle(cornerRadius: 10)
            .frame(height: 55)
            .foregroundColor(item.color)
            .overlay {
                HStack{
                    Image(item.rawValue)
                        .resizable()
                        .frame(width:item == .naver ? 35 : 25,height:item == .naver ? 35:25)
                        .offset(x:item == .naver ? 0:-5)
                    Spacer()
                }
                .padding()
            }
            .overlay{
                Text("\(item.text)")
                    .font(.GmarketSansTTFMedium(15))
                    .foregroundColor(item.textColor)
            }
    }
}

