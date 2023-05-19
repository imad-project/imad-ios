//
//  InfoChangeView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/18.
//

import SwiftUI

struct InfoChangeView: View {
    let title:String
    let password:Bool
    @State var old = ""
    @State var passwordConfirm:String = ""
    @State var text = ""
    @State var alertMsg = ""
    @State var notRegex = false
    @State var success = false
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var body: some View {
        VStack(alignment: .leading,spacing: 0){
            ZStack{
                HStack{
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .bold()
                    }
                    Spacer()
                    Button {
                        if password{
                            switch isVaildInfo(){
                            case 1:
                                alertMsg = "비밀번호는 영문 대,소문자, 숫자, 특수문자만 허용되며 8~20자 사이여야 합니다!"
                                return notRegex = true
                            case 2:
                                alertMsg = "비밀번호가 일치하지 않습니다!"
                                return notRegex = true
                            default:
                                return vmAuth.passwordChange(old: old, new: text) //SHA256
                                
                            }
                        }
                    } label: {
                        Text("변경")
                            .bold()
                    }
                }
                Text(title + " 변경")
                    .bold()
            }.foregroundColor(.primary)
            .padding(.top,20)
           .padding(.bottom,50)
            if password{
                
                Text("기존 비밀번호")
                    .bold()
                    .foregroundColor(.primary)
                    .padding(.bottom,10)
                CustomTextField(password: password, image: nil, placeholder: title, color: .primary, text: $old)
                    .padding(.bottom,10)
                Divider()
                    .background(Color.primary)
                    .padding(.bottom,50)
                
                Text("변경 비밀번호")
                    .bold()
                    .foregroundColor(.primary)
                    .padding(.bottom,10)
            }
            CustomTextField(password: password, image: nil, placeholder: title + " ..", color: .primary, text: $text)
                .padding(.bottom,10)
            Divider()
                .background(Color.primary)
                .padding(.bottom)
            if password{
                CustomTextField(password: password, image: nil, placeholder: title + " 확인 ..", color: .primary, text: $passwordConfirm)
                    .padding(.bottom,10)
                Divider()
                    .background(Color.primary)
                    .padding(.bottom,10)
                
               
            }
            Spacer()
            
        }
        .foregroundColor(.white)
        .padding()
        .onReceive(vmAuth.passwordChangeSuccess){
            success = true
            alertMsg = vmAuth.passwordChangeRes?.message ?? ""
            notRegex = true
        }
        .background{
            ZStack{
                Color.antiPrimary
                ProfileChangeView()
                    .allowsHitTesting(false)
                    .blur(radius: 20)
                    .opacity(0.1)

            }.ignoresSafeArea()
        }
        .alert(isPresented: $notRegex){
            Alert(title: Text(success ? "성공":"오류"),message: Text(alertMsg),dismissButton: .default(Text("확인")){
                if success{
                    dismiss()
                }
            })
        }
        .navigationBarBackButtonHidden(true)
    }
    func isVaildInfo()->Int{
        
        let passwordRegex = "[A-Za-z0-9!_@$%^&+=]{8,20}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        
        if !passwordPredicate.evaluate(with: text){
            return 1
        }else if text != passwordConfirm{
            return 2
        }else{
            return 0
        }
    }
}

struct InfoChangeView_Previews: PreviewProvider {
    static var previews: some View {
        
        InfoChangeView(title: "비밀번호", password: true, text: "quarang")
            .environmentObject(AuthViewModel())
    }
}
