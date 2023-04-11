//
//  LogionView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/11.
//

import SwiftUI

struct LogionView: View {
    
    @State var phase:CGFloat = 0.0
    @State var id = ""
    @State var password = ""
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            Color.white.ignoresSafeArea()
            Wave(progress: 0.83, phase: phase).fill(Color.customIndigo)
                .onAppear{
                    withAnimation(.linear(duration: 3).repeatForever(autoreverses:false)){
                        self.phase = .pi * 2
                    }
                }
                .ignoresSafeArea()
            Wave(progress: 0.9, phase:0).fill(Color.customIndigo.opacity(0.5))
                .shadow(radius: 20)
            VStack(alignment: .leading,spacing: 30){
                Spacer()
                Group{
                    Text("로그인하기")
                        .font(.title)
                        .bold()
                    Text("아이디").bold()
                    CustomTextField(password: false, image: "person.fill", placeholder: "입력", color: Color.white, text: $id).padding(.leading)
                    Text("비밀번호").bold()
                    CustomTextField(password: true, image: "lock.fill", placeholder: "입력", color: Color.white, text: $password).padding(.leading)
                        .padding(.bottom,50)
                }
                Button {
                    
                } label: {
                    Capsule()
                        .frame(width: .infinity,height: 50)
                        .overlay {
                            Text("로그인")
                                .bold()
                                .foregroundColor(.customIndigo)
                                .shadow(radius: 20)
                        }
                }
                Spacer()
                HStack{
                    Text("계정이 없으신가요?")
                    Text("회원가입")
                        .bold()
                }.font(.caption)
                    .frame(maxWidth: .infinity)
                

                    
            }.foregroundColor(.white)
                .padding()
            Image("fish")
                .resizable()
                .frame(width: 100,height: 70)
                .padding(.bottom,100)
                .padding(.trailing,50)
                .shadow(radius: 20)
        }
    }
}

struct LogionView_Previews: PreviewProvider {
    static var previews: some View {
        LogionView()
    }
}

