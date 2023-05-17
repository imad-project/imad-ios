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
    
    @State var kakao = false
    @State var naver = false
    @State var apple = false
    
    @State var generalLogin = false
    @EnvironmentObject var vm:AuthViewModel
    
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
                        }
                        VStack(spacing: 20){
                            Button {
                                generalLogin = true
                            } label: {
                                HStack{
                                    Image("logo")
                                        .resizable()
                                        .frame(width: 20,height: 20)
                                    Spacer()
                                }
                                .padding(15)
                                .background(Color.white)
                                .cornerRadius(10)
                                .padding(5)
                                .overlay {
                                    Text("IMAD로 로그인하기")
                                        .bold()
                                    
                                }
                                .foregroundColor(.black)
                            }

                            ForEach(OauthFilter.allCases,id:\.rawValue){ item in
                                Button {
                                    switch item{
                                    case .Apple:
                                        apple = true
                                    case .naver:
                                        naver = true
                                    case .kakao:
                                        kakao = true
                                    }
                                } label: {
                                    HStack{
                                        Image(item.rawValue)
                                            .resizable()
                                            .frame(width: 25,height: 25)
                                        Spacer()
                                    }
                                    .padding(15)
                                    .background(item.color)
                                    .cornerRadius(10)
                                    .padding(5)
                                    .overlay{
                                        Text("\(item.text)")
                                            .bold()
                                            .foregroundColor(item.textColor)
                                    }
                                }
                            }
                        }
                        
                        Text("계정이 없으신가요?")
                            .font(.caption)
                            .frame(maxWidth: .infinity)
                        Button {
                            register = true
                        } label: {
                            HStack{
                                Image("logoName")
                                    .resizable()
                                    .frame(width: 20,height: 20)
                                Spacer()
                            }
                            .padding(15)
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding(5)
                            .overlay {
                                Text("새로 시작하기")
                                    .bold()
                                
                            }
                            .foregroundColor(.black)
                        }
                        .navigationDestination(isPresented: $register) {
                            RegisterView(login: $register)
                                .navigationBarBackButtonHidden(true)
                        }
                        Spacer()

                    }.ignoresSafeArea(.keyboard)
                    .foregroundColor(.white)
                        .padding()
                        .transition(.move(edge: .leading))
            }
            .sheet(isPresented: $generalLogin){
                LoginView()
                    .environmentObject(vm)
                    .navigationBarBackButtonHidden()
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

