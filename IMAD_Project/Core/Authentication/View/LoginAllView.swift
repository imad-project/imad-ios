//
//  LoginAllView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/16.
//

import SwiftUI

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
                            Text("아이디").bold()
                                .foregroundColor(.customIndigo)
                            CustomTextField(password: false, image: "person.fill", placeholder: "입력..", color: Color.gray, text: $id)
                                .keyboardType(.emailAddress)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 4).foregroundColor(.customIndigo))
                                .cornerRadius(20)
                                .padding(.horizontal,5)
                            Text("비밀번호").bold()
                                .foregroundColor(.customIndigo)
                            CustomTextField(password: true, image: "lock.fill", placeholder: "입력..", color: Color.gray, text: $password)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 4).foregroundColor(.customIndigo))
                                .cornerRadius(20)
                                .padding(.horizontal,5)
                                .padding(.bottom,20)
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
                                vm.login(email: id, password: password)    //SHA256
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
                                .background(.white)
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
                                    case .Google:
                                        google = true
                                    }
                                } label: {
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
                                    }
                                    .padding(15)
                                    .background(RoundedRectangle(cornerRadius: 20).frame(height: 55).foregroundColor(item.color))
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
//                        .background(.red)
                        
                }
                 
            }
            .sheet(isPresented: $register) {
                RegisterView(login: $register)
                    .environmentObject(vm)
                    .navigationBarBackButtonHidden(true)
            }
            .sheet(isPresented: $apple){
                AuthWebView(filter: .Apple)
                    .ignoresSafeArea()
                    .environmentObject(vm)
            }
            .sheet(isPresented: $naver){
                AuthWebView(filter: .naver)
                    .environmentObject(vm)
                    .ignoresSafeArea()
            }
            .sheet(isPresented:$kakao){
                AuthWebView(filter: .kakao)
                    .ignoresSafeArea()
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
                Alert(title: Text(vm.getUserRes?.message ?? ""),dismissButton: .default(Text("확인")) {
                    vm.loginMode = msg
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

