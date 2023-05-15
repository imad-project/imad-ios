//
//  LogionView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/11.
//

import SwiftUI

struct LogionView: View {
    
    @State var register = false
    @State var phase:CGFloat = 0.0
    @State var id = ""
    @State var password = ""
    @Binding var login:Bool
    @State var success = false
    @State var msg = false
    @State var oauht = false
    @StateObject var vm = AuthViewModel()
    @State var kakaoLogin = false
    @StateObject var kakaoVm = KakaoAuthViewModel()
//    let apiKey = Bundle.main.infoDictionary?["REST_API_KEY"] ?? ""   //restApiKey
//    let baseURL = "http://39.119.82.229:8080//login/oauth2/code/kakao"
    
    var body: some View {
            ZStack{
                BackgroundView(height: 0.73, height1: 0.77,height2: 0.75,height3: 0.76)
                    VStack(alignment: .leading,spacing: 30){
                        Group{
                            Text("환영합니다")
                                .font(.title)
                                .bold()
                                .foregroundColor(.customIndigo)
                                .padding(.top,50)
                            Spacer()
                            Text("아이디").bold()
                            CustomTextField(password: false, image: "person.fill", placeholder: "입력", color: Color.white, text: $id).padding(.leading)
                            Text("비밀번호").bold()
                            CustomTextField(password: true, image: "lock.fill", placeholder: "입력", color: Color.white, text: $password).padding(.leading)
                                .padding(.bottom,50)
                        }
                        Button {
                            vm.login(email: id, password: password)
                            //login = true
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
                                }
                        }
                        HStack(spacing: 20){
                            button(action: (), view: Image("apple").resizable().frame(width: 30,height: 30), buttonColor: .black, textColor: .customIndigo)
                            button(action: (), view: Image("naver").resizable().frame(width: 40,height: 40), buttonColor: .green, textColor: .customIndigo)
                            Button {
                                //kakaoVm.handleKakaoLogin()
                                //vm.oauth(registrationId: "kakao")
                                oauht = true
                            } label: {
                                Capsule()
                                    .frame(height: 50)
                                    .foregroundColor(.yellow)
                                    .frame(maxWidth: .infinity)
                                    .overlay {
                                        Image("kakao").resizable().frame(width: 30,height: 30)
                                    }
                            }

                        }
                        Spacer()
                        HStack{
                            Group{
                                Text("회원가입")
                                    .onTapGesture {
                                        withAnimation {
                                            register.toggle()
                                        }
                                    }.navigationDestination(isPresented: $register) {
                                        RegisterView(login: $register)
                                            .navigationBarBackButtonHidden(true)
                                    }
                                Text("|")
                                Text("아이디 찾기")
                                Text("|")
                                Text("비밀번호 찾기")
                            }.bold()
                                .shadow(radius: 20)
                        }
                        .font(.caption)
                        .frame(maxWidth: .infinity)

                    }.ignoresSafeArea(.keyboard)
                    .foregroundColor(.white)
                        .padding()
                        .transition(.move(edge: .leading))
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            .onReceive(vm.loginSuccess) { value in
                success = true
                msg = value
            }
            .alert(isPresented: $success) {
                Alert(title: Text("로그인에 성공했습니다."),dismissButton: .default(Text("확인")) {
                    login = msg
                })
            }
            .onReceive(vm.oauthSuccess) { _ in
                kakaoLogin = true
            }
//            .onChange(of: kakaoVm.htmlString) { _ in
//                kakaoLogin = true
//                print("카카오 로그인 성공 \(kakaoLogin)")
//            }
            .sheet(isPresented: /*$kakaoLogin*/$oauht) {
                ZStack{
                    KakaoWebView(url:"http://39.119.82.229:8080/oauth2/authorization/kakao")
                        .environmentObject(kakaoVm)

                }


            }
        }
        
        
    
}

struct LogionView_Previews: PreviewProvider {
    static var previews: some View {
        LogionView(login: .constant(false))
    }
}

extension LogionView{
    func button(action:(),view:some View,buttonColor:Color,textColor:Color?) -> some View{
        Button {
            action
        } label: {
            Capsule()
                .frame(height: 50)
                .foregroundColor(buttonColor)
                .frame(maxWidth: .infinity)
                .overlay {
                    view
                        .bold()
                        .foregroundColor(textColor)
                        .shadow(radius: 20)
                }
        }
    }
}
