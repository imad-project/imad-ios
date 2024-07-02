//
//  LoginAllView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/16.
//

import SwiftUI
import Alamofire
import AuthenticationServices

struct LoginAllView: View{
    

    @State var oathFilter = OauthFilter(rawValue: "")
    @State var register = false
    
    @State var id = ""
    @State var password = ""
    
    @State var success = false
    @State var msg = ""
    
    @State var kakao = false
    @State var naver = false
    @State var google = false
    @State var domain = EmailFilter.gmail
    
    @State var loading = false
    @EnvironmentObject var vm:AuthViewModel
    
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            ScrollView{
                VStack(spacing: 10){
                    Text("환영합니다")
                        .font(.title)
                        .bold()
                        .foregroundColor(.customIndigo)
                        .padding(.top,20)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom)
                    VStack(alignment: .leading){
                        emailView
                        passwordView
                        authView
                    }.padding(.horizontal,10)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                        }
                    Spacer()
                    divderView
                    loginButtonView
                }
                .foregroundColor(.gray)
                .padding()
            }
            if loading{
                CustomProgressView()
            }
        }
        .onReceive(vm.loginSuccess){ value in
            success = true
            msg = value
        }
        .alert(isPresented: $success){
            Alert(title: Text(msg),dismissButton: .cancel(Text("확인")){
                loading = false
            })
        }
        .sheet(isPresented: $register) {
            RegisterView(login: $register)
                .environmentObject(vm)
                .navigationBarBackButtonHidden(true)
                .onDisappear{
                    loading = false
                }
        }
        .sheet(isPresented: $naver){
            AuthWebView(filter: .naver)
                .environmentObject(vm)
                .ignoresSafeArea()
                .onDisappear{
                    loading = false
                }
        }
        .sheet(isPresented:$kakao){
            AuthWebView(filter: .kakao)
                .environmentObject(vm)
                .ignoresSafeArea()
                .onDisappear{
                    loading = false
                }
        }
        .sheet(isPresented:$google){
            AuthWebView(filter: .google)
                .environmentObject(vm)
                .ignoresSafeArea()
                .onDisappear{
                    loading = false
                }
        }
        .ignoresSafeArea(.keyboard)
        
    }
}

struct LoginAllView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            LoginAllView()
                .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
        }
    }
}

extension LoginAllView{
    var emailView:some View{
        VStack(alignment: .leading){
            Text("이메일").bold()
                .foregroundColor(.customIndigo)
            Group{
                HStack{
                    VStack{
                        CustomTextField(password: false, image: "person.fill", placeholder: "입력..", color: Color.gray, text: $id)
                            .keyboardType(.emailAddress)
                            .padding(.vertical,5)
                        Divider()
                            .frame(height: 1)
                            .background(Color.customIndigo)
                    }
                    Text("@").padding(.leading)
                    Picker("", selection: $domain) {
                        ForEach(EmailFilter.allCases,id:\.self){ item in
                            Text(item.domain)
                        }
                    }.accentColor(.black)
                        .frame(maxWidth: .infinity)
                }.padding(.top,5)
            }.padding(.leading)
                .padding(.vertical,5)
        }
    }
    var passwordView:some View{
        VStack(alignment: .leading) {
            Text("비밀번호").bold()
                .foregroundColor(.customIndigo)
            Group{
                CustomTextField(password: true, image: "lock.fill", placeholder: "입력..", color: Color.gray, text: $password)
                    .padding(.top,5)
                Divider()
                    .frame(height: 1)
                    .background(Color.customIndigo)
                    .padding(.bottom,30)
            }.padding(.horizontal)
                .padding(.vertical,5)
        }
    }
    var authView:some View{
        VStack(alignment: .leading) {
            HStack{
                Text("이메일 찾기")
                Text("  |  ")
                Text("비밀번호 찾기")
                Spacer()
                Button {
                    register = true
                } label: {
                    Text("회원가입")
                }
            }.padding(.horizontal,20)
                .font(.caption)
            
            Button {
                vm.login(email: "\(id)@\(domain.domain)", password: password)    //SHA256
                loading = true
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 55)
                    .foregroundColor(.customIndigo)
                    .frame(maxWidth: .infinity)
                    .overlay {
                        Text("로그인")
                            .bold()
                            .foregroundColor(.white)
                            .shadow(radius: 20)
                        
                        
                    }.padding(.horizontal,5)
            } .padding(.bottom,50)
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
                .font(.caption)
                .foregroundColor(.customIndigo)
            VStack{
                Divider()
                    .frame(height: 1)
                    .background(Color.customIndigo)
            }
        }.padding(.horizontal)
    }
    
    var loginButtonView:some View{
        VStack{
            appleLoginButton
                .overlay {
                    loginButton(item: .Apple)
                        .allowsHitTesting(false)
                }
            ForEach(OauthFilter.allCases.filter{$0 != .Apple},id:\.rawValue){ item in
                Button {
                    switch item{
                    case .Apple:
                        return
                    case .naver:
                        naver = true
                    case .kakao:
                        kakao = true
                    case .google:
                        google = true
                    }
                    loading = true
                } label: {
                    loginButton(item: item)
                }.shadow(color:.gray.opacity(0.3),radius: 3)
            }
        }.padding(.horizontal)
    }
    var appleLoginButton:some View{
        SignInWithAppleButton(
            onRequest: { request in
                request.requestedScopes = [.fullName, .email,]
            },
            onCompletion: { result in
                vm.appleLogin(result: result)
            }
        )
        .frame(height:50)
        .cornerRadius(20)
    }
    func loginButton(item:OauthFilter) -> some View{
        RoundedRectangle(cornerRadius: 20).frame(height: 55)
            .foregroundColor(item.color)
            .overlay {
                HStack{
                    if item == .naver{
                        Image(item.rawValue)
                            .resizable()
                            .frame(width: 35,height: 35)
                            .offset(x:-5)
                    }else{
                        Image(item.rawValue)
                            .resizable()
                            .frame(width: 25,height: 25)
                    }
                    
                    Spacer()
                }.padding()
            }
            .overlay{
                Text("\(item.text)")
                    .bold()
                    .foregroundColor(item.textColor)
            }
    }
}

