//
//  LoginAllView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/16.
//

import SwiftUI
import Alamofire

struct LoginAllView: View {
    
    @State var oathFilter = OauthFilter(rawValue: "")
    @State var register = false
    
    @State var id = ""
    @State var password = ""
    
    @State var success = false
    @State var msg = false
    @State var oauth = false
    
    @State var kakao = false
    @State var naver = false
    @State var apple = false
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
                            .onTapGesture {
                                vm.getUser()
                            }
                            .font(.title)
                            .bold()
                            .foregroundColor(.customIndigo)
                            .padding(.top,20)
                            .frame(maxWidth: .infinity)
                            .padding(.bottom)
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
                        }.padding(.horizontal,10)
                        
                   
                        Spacer()
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
                           
                            ForEach(OauthFilter.allCases,id:\.rawValue){ item in
                                Button {
                                    switch item{
                                    case .Apple:
                                        apple = true
                                    case .naver:
                                        naver = true
                                    case .kakao:
                                        kakao = true
                                    case .google:
                                        google = true
                                    }
                                    loading = true
                                } label: {
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
                                }.shadow(color:.gray.opacity(0.3),radius: 3)
                            }.padding(.horizontal)
                        
                    }
                    .foregroundColor(.gray)
                        .padding()
                        
                }
                if loading{
                    Color.gray.opacity(0.5).ignoresSafeArea()
                     CustomProgressView()
                }
                
            }
            .sheet(isPresented: $register) {
                RegisterView(login: $register)
                    .environmentObject(vm)
                    .navigationBarBackButtonHidden(true)
                    .onDisappear{
                        loading = false
                    }
            }
            .sheet(isPresented: $apple){
                AuthWebView(filter: .Apple)
                    .ignoresSafeArea()
                    .environmentObject(vm)
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
                    .ignoresSafeArea()
                    .onDisappear{
                        loading = false
                    }
            }
            .sheet(isPresented:$google){
                AuthWebView(filter: .google)
                    .ignoresSafeArea()
                    .onDisappear{
                        loading = false
                    }
            }
            .ignoresSafeArea(.keyboard)
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            .onReceive(vm.loginSuccess) { value in
                success = true
                msg = value
            }
            .alert(isPresented: $success) {
                Alert(title: Text(vm.getUserRes?.message),dismissButton: .default(Text("확인")) {
                    vm.loginMode = msg
                    loading = false
                })
            }
        }
}

struct LoginAllView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            LoginAllView()
                .environmentObject(AuthViewModel())
        }
    }
}

