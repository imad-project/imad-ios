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
    @State var text = ""
    @State var passwordConfirm:String = ""
    
    
    @State var age = 0
    @State var gender = ""
    
    @State var alertMsg = ""
    @State var notRegex = false
    @State var success = false
    @State var tokenExpired = (false,"")
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var body: some View {
        VStack(alignment: .leading,spacing: 0){
            header
            if title == "성별"{
                HStack{
                    genderSelectView(gender: "MALE")
                    genderSelectView(gender: "FEMALE")
                }
            }else if title == "나이"{
               ageSelectView
            }
            else{
                if password{
                    passwordChageView
                }
                textFieldView(placeHolder: " ..", text: $text)
                if password{
                    textFieldView(placeHolder: " 확인 ..", text: $passwordConfirm)
                }
            }
            Spacer()
        }
        .foregroundColor(.black)
        .padding()
//        .onReceive(vmAuth.passwordChangeSuccess){
//            success = true
//            alertMsg = vmAuth.passwordChangeRes?.message ?? ""
//            notRegex = true
//        }
        .background(Color.white.ignoresSafeArea())
        .alert(isPresented: $notRegex){
            Alert(title: Text(success ? "성공":"오류"),message: Text(alertMsg),dismissButton: .default(Text("확인")){
                if success{
                    dismiss()
                }
            })
        }
        //        .onReceive(vmAuth.tokenExpired) { messages in
        //            tokenExpired = (true,messages)
        //        }
        //        .alert(isPresented: $tokenExpired.0) {
        //            Alert(title: Text("토큰 만료됨"),message: Text(tokenExpired.1),dismissButton:.cancel(Text("확인")){
        //                vmAuth.loginMode = false
        //            })
        //        }
        //        .navigationBarBackButtonHidden(true)
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
        
        InfoChangeView(title: "", password: true, text: "quarang")
            .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
    }
}


extension InfoChangeView{
    var header:some View{
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
                        chanagePassword()
                    }else{
                        chageUserinfo()
                    }
                    dismiss()
                } label: {
                    Text("변경")
                        .bold()
                }
            }
            Text(title + " 변경")
                .bold()
        }
        .padding(.top,20)
        .padding(.bottom,50)
        
    }
    func genderSelectView(gender:String) -> some View{
        HStack{
            VStack{
                Button {
                    self.gender = gender
                } label: {
                    Image(gender)
                        .resizable()
                        .frame(width: 65,height: 80)
                        .padding(30)
                        .overlay {
                            if self.gender == gender{
                                Circle().foregroundColor(.black.opacity(0.5))
                            }
                        }
                }
                Text(gender == "MALE" ? "남성" : "여성")
                    .fontWeight(self.gender  == gender ? .bold:.none)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom)
    }
    var ageSelectView:some View{
        HStack{
            Spacer()
            Picker("", selection: $age) {
                ForEach(0...100, id: \.self) {
                    Text("\($0) 세")
                }
            }
            .colorScheme(.light)
            .pickerStyle(InlinePickerStyle())
            .frame(width:150,height: 150)
            .overlay(alignment:.leading){
                Text("만").offset(x:-20)
            }
            Spacer()
        }
    }
    func textFieldView(placeHolder:String,text:Binding<String>)->some View{
        VStack{
            CustomTextField(password: password, image: nil, placeholder: title + placeHolder, color: .black, text: text)
                .padding(.bottom,10)
            Divider()
                .background(Color.black)
                .padding(.bottom)
        }
    }
    var passwordChageView:some View{
        VStack(alignment: .leading){
            Text("기존 비밀번호")
                .bold()
                .padding(.bottom,10)
            CustomTextField(password: password, image: nil, placeholder: title, color: .black, text: $old)
                .padding(.bottom,10)
            Divider()
                .background(Color.black)
                .padding(.bottom,50)
            Text("변경 비밀번호")
                .bold()
                .padding(.bottom,10)
        }
    }
    func chanagePassword(){
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
    func chageUserinfo(){
        switch title{
        case "닉네임":
            vmAuth.patchUser.nickname = text
        case "성별":
            vmAuth.patchUser.gender = gender
        case "나이":
            vmAuth.patchUser.age = age
        default:
            return
        }
        vmAuth.patchUserInfo()
    }
}
