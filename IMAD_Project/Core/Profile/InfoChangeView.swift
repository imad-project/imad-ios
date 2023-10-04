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
    @State var age = -1
    @State var gender = ""
    
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
                        }else{
                            guard let data = vmAuth.getUserRes?.data else {return}
                            switch title{
                            case "닉네임":
                                vmAuth.patchUser(gender: data.gender ?? "", ageRange: data.ageRange, image:data.profileImage, nickname: text, tvGenre: data.tvGenre ?? [],movieGenre: data.movieGenre ?? [])
                            case "성별":
                                vmAuth.patchUser(gender: gender, ageRange: data.ageRange, image:data.profileImage, nickname: data.nickname ?? "", tvGenre: data.tvGenre ?? [],movieGenre: data.movieGenre ?? [])
                            case "나이":
                                vmAuth.patchUser(gender: data.gender, ageRange: age, image:data.profileImage, nickname: data.nickname ?? "", tvGenre: data.tvGenre ?? [],movieGenre: data.movieGenre ?? [])
                            default:
                                return
                            }
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
            if title == "성별"{
                HStack{
                    VStack{
                        Button {
                            gender = "MALE"
                        } label: {
                            Circle()
                                .foregroundColor(.white)
                                .frame(width: 150,height: 150)
                                .overlay {
                                    if gender == "MALE"{
                                        Circle().foregroundColor(.black.opacity(0.5))
                                    }
                                    Image("MALE")
                                        .resizable()
                                        .frame(width: 80,height: 80)
                                        .shadow(radius: 20)
                                        .opacity(gender == "MALE" ? 1.0 :0.5)
                                }
                        }
                        Text("남성")
                            .fontWeight(gender == "MALE" ? .bold:.none)
                        
                    }
                    Spacer().frame(width: 50)
                    VStack{
                        Button {
                            gender = "FEMALE"
                        } label: {
                            Circle()
                                .foregroundColor(.white)
                                .frame(width: 150,height: 150)
                                .overlay {
                                    if gender == "FEMALE"{
                                        Circle().foregroundColor(.black.opacity(0.5))
                                    }
                                    Image("FEMALE")
                                        .resizable()
                                        .frame(width: 75,height: 75)
                                        .shadow(radius: 20)
                                        .opacity(gender == "FEMALE" ? 1.0 :0.5)
                                    
                                }
                        }
                        Text("여성")
                            .fontWeight(gender == "FEMALE" ? .bold:.none)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom)
            }else if title == "나이"{
                HStack{
                    Spacer()
                    
                    Picker("", selection: $age) {
                        ForEach(0...100, id: \.self) {
                            Text("\($0) 세")
                        }
                    }.colorScheme(.light)
                    .pickerStyle(InlinePickerStyle())
                    .frame(width:150,height: 150)
                    .overlay(alignment:.leading){
                        Text("만").offset(x:-20)
                    }
                    Spacer()
                }
            }
            else{
                if password{
                    
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
                CustomTextField(password: password, image: nil, placeholder: title + " ..", color: .black, text: $text)
                    .padding(.bottom,10)
                Divider()
                    .background(Color.black)
                    .padding(.bottom)
                if password{
                    CustomTextField(password: password, image: nil, placeholder: title + " 확인 ..", color: .black, text: $passwordConfirm)
                        .padding(.bottom,10)
                    Divider()
                        .background(Color.black)
                        .padding(.bottom,10)
                    
                    
                }
            }
            Spacer()
            
        }
        .foregroundColor(.black)
        .padding()
        .onAppear{
            age = vmAuth.getUserRes?.data?.ageRange ?? -1
            gender = vmAuth.getUserRes?.data?.gender ?? ""
        }
        .onReceive(vmAuth.passwordChangeSuccess){
            success = true
            alertMsg = vmAuth.passwordChangeRes?.message ?? ""
            notRegex = true
        }
        .background(Color.white.ignoresSafeArea())
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
        
        InfoChangeView(title: "나이", password: false, text: "quarang")
            .environmentObject(AuthViewModel())
    }
}
