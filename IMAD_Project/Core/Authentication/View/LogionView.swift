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

    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottomTrailing){
                BackgroundView(height: 0.73, height1: 0.8)
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
                        button(action: (), view: Text("로그인"), buttonColor: .white, textColor: .customIndigo)
                        HStack(spacing: 20){
                            button(action: (), view: Image("apple").resizable().frame(width: 30,height: 30), buttonColor: .black, textColor: .customIndigo)
                            button(action: (), view: Image("google").resizable().frame(width: 30,height: 30), buttonColor: .white, textColor: .customIndigo)
                            button(action: (), view: Image("kakao").resizable().frame(width: 30,height: 30), buttonColor: .yellow, textColor: .customIndigo)
                        }
                        .shadow(radius: 20)
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
                            
                        }
                        .font(.caption)
                        .frame(maxWidth: .infinity)

                    }
                    .foregroundColor(.white)
                        .padding()
                        .transition(.move(edge: .leading))
                }
            
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        
    }
}

struct LogionView_Previews: PreviewProvider {
    static var previews: some View {
        LogionView()
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
