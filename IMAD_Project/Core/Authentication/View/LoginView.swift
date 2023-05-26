//
//  LogionView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/11.
//

import SwiftUI

struct LoginView: View {
    
    @State var id = ""
    @State var password = ""
    
    @State var success = false
    @State var msg = false
    @State var oauth = false
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm:AuthViewModel
    
    var body: some View{
        ZStack(alignment: .bottomTrailing){
            Color.white.ignoresSafeArea()
            BackgroundView(height: 0.33, height1: 0.37,height2: 0.35,height3: 0.36)
            VStack(alignment: .leading){
                Group{
                    Text("로그인하기")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.customIndigo)
                        .padding(.vertical,20)
                        .frame(maxWidth: .infinity)
                    Text("아이디").bold()
                    CustomTextField(password: false, image: "person.fill", placeholder: "입력..", color: Color.gray, text: $id)
                        .keyboardType(.emailAddress)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(20)
                        .padding(.bottom)
                        .padding(.horizontal,5)
                    Text("비밀번호").bold()
                    CustomTextField(password: true, image: "lock.fill", placeholder: "입력..", color: Color.gray, text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(20)
                        .padding(.horizontal,5)
                        .padding(.bottom,40)
                    Button {
                        vm.login(email: id, password: password)    //SHA256
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 60)
                            .foregroundColor(.customIndigo)
                            .frame(maxWidth: .infinity)
                            .overlay {
                                Text("로그인")
                                    .bold()
                                    .foregroundColor(.white)
                                    .shadow(radius: 20)
                                    
                        
                            }.padding(.horizontal,5)
                    }
                    .padding(.bottom)
                }.padding(.horizontal,10)
                HStack{
                    Text("계정을 잃어버리셨나요?")
                    Text("아이디 찾기").bold()
                    Text("|").bold()
                    Text("비밀번호 찾기").bold()
                }
                .font(.caption)
                .frame(maxWidth: .infinity)
                Spacer()
            }.foregroundColor(.customIndigo)
            Image("watch")
                .resizable()
                .frame(width: 150,height: 100)
                .padding()
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

struct LogionView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}


