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
    @State var domain:EmailFilter = .gmail
    
    @State var age = 0
    @State var gender = ""
    
    @State var alertMsg = ""
    @State var notRegex = false
    @State var success = false
    @State var tokenExpired = (false,"")
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vmAuth:AuthViewModel
    var currentDate :Int{
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)

        return components.year!
    }
    var body: some View {
        VStack(alignment: .leading,spacing: 0){
            header
            ScrollView(showsIndicators: false){
                VStack{
                    Divider()
                    if title == "성별"{
                        genderSelectView(gender: "MALE").padding(.top)
                        genderSelectView(gender: "FEMALE")
                            
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
                    Button {
                        if password{
                            chanagePassword()
                        }else{
                            chageUserinfo()
                        }
                        dismiss()
                    } label: {
                        Text("변경")
                            .foregroundColor(.white)
                            .font(.GmarketSansTTFMedium(15))
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .bold()
                            .background(Color.customIndigo)
                            .cornerRadius(10)
                    }
                    .padding(.vertical,20)
                    .padding(10)
                    Divider()
                }
                .background(Color.white)
                .padding(.top,10)
                
            }
            
        }
        .foregroundColor(.black)
        .background(Color.gray.opacity(0.1))
        .alert(isPresented: $notRegex){
            Alert(title: Text(success ? "성공":"오류"),message: Text(alertMsg),dismissButton: .default(Text("확인")){
                if success{
                    dismiss()
                }
            })
        }
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
        
        InfoChangeView(title: "닉네임", password: true, text: "quarang")
            .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
    }
}


extension InfoChangeView{
    var header:some View{
        VStack{
            HStack{
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .bold()
                }
                Text(title + " 변경")
                    .font(.GmarketSansTTFMedium(25))
                    .bold()
                Spacer()
            }
            .padding(10)
            Divider()
        }
        .background(Color.white)
    }
    func genderSelectView(gender:String) -> some View{
       
            Button {
                self.gender = gender
            } label: {
                HStack{
                    Image(gender)
                        .resizable()
                        .frame(width: 20,height: 25)
                    Text(gender == "MALE" ? "남성" : "여성")
                        .fontWeight(self.gender  == gender ? .bold:.none)
                    Spacer()
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            }
            .overlay {
                if self.gender == gender{
                    Color.black.opacity(0.5).cornerRadius(10)
                }
            }
            .padding(.horizontal)
            
    }
    var ageSelectView:some View{
        HStack{
            Spacer()
            Picker("", selection: $age) {
                ForEach(1900...currentDate, id: \.self) {
                    Text("\($0)")
                }
            }
            .colorScheme(.light)
            .pickerStyle(InlinePickerStyle())
            .frame(width:150,height: 150)
            .overlay(alignment:.trailing){
                Text("년")
                    .font(.GmarketSansTTFMedium(15))
                    .offset(x:20)
            }
            Spacer()
        }
        .padding(.vertical)
    }
    func textFieldView(placeHolder:String,text:Binding<String>)->some View{
        VStack{
            CustomTextField(password: password, image: nil, placeholder: title + placeHolder, color: .black.opacity(0.5), text: text)
                .padding(.top,10)
            Divider()
                .background(Color.black)
                .padding(.vertical,5)
        }.padding(.horizontal)
    }
    var passwordChageView:some View{
        VStack(alignment: .leading){
            Text("기존 비밀번호")
                .font(.GmarketSansTTFMedium(15))
                .padding(.vertical,10)
            CustomTextField(password: password, image: nil, placeholder: title, color: .black.opacity(0.5), text: $old)
                .padding(.horizontal,5)
            Divider()
                .background(Color.black)
                .padding(.bottom,50)
                .padding(.horizontal,5)
            Text("변경 비밀번호")
                .font(.GmarketSansTTFMedium(15))
                .padding(.bottom,10)
        }.padding(.horizontal,10)
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
