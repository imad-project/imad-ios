//
//  ProfileChangeView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/18.
//

import SwiftUI
import Kingfisher
import PhotosUI

struct ProfileChangeView: View {
    
    @State var delete = false
    @State var logout = false
    
    @StateObject var vmAuth = AuthViewModel(user:nil)
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
                VStack(spacing:0){
                   header
                        List{
                            Group{
                                if let user = vmAuth.user{
                                    navigatoionChangeView(view: InfoChangeView(title: "닉네임", password: false, text:user.nickname ?? ""), text: "닉네임 변경")
                                    navigatoionChangeView(view: InfoChangeView(title: "성별", password: false,gender: user.gender ?? ""), text: "성별 변경")
                                    navigatoionChangeView(view: InfoChangeView(title: "나이", password: false,age: user.birthYear), text: "나이 변경")
                                    if user.authProvider == "IMAD"{
                                        navigatoionChangeView(view: InfoChangeView(title: "비밀번호", password: true), text: "비밀번호 변경")
                                    }
                                }
                                
                                actionButtonView(action: {
                                    logout = true
                                    delete = false
                                }, text: "로그아웃")
                                actionButtonView(action: {
                                    logout = true
                                    delete = true
                                }, text: "회원탈퇴").foregroundColor(.red)
                            }
                            .listRowBackground(Color.white)
                        }
                        .scrollContentBackground(.hidden)
                        .listStyle(.plain)
                        
                        Spacer()
                    
                    
                }
                .background(Color.gray.opacity(0.1).ignoresSafeArea())
        .foregroundColor(.black)
        .alert(isPresented: $logout) {
            alert()
        }
    }
}

struct ProfileChangeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileChangeView()
               
        }
        
    }
}

extension ProfileChangeView{
    var header:some View{
        VStack(spacing:0){
            HStack{
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
                Text("개인 정보 변경")
                    .font(.GmarketSansTTFMedium(25))
                    .bold()
                Spacer()
            }
            .padding(10)
            Divider()
        }
        .background(Color.white)
        .padding(.bottom,10)
    }
    func navigatoionChangeView(view:some View,text:String) -> some View{
        NavigationLink {
            view
               
                .navigationBarBackButtonHidden()
        } label: {
            Text(text)
                .font(.GmarketSansTTFMedium(15))
        }
    }
    func actionButtonView(action:@escaping () -> (),text:String) -> some View{
        Button (action:action){
            Text(text)
                .font(.GmarketSansTTFMedium(15))
        }
    }
    func alert() -> Alert{
        Alert(
            title: delete ? Text("회원탈퇴"): Text("로그아웃"),
            message: delete ? Text("정말로 회원을 탈퇴하시겠습니까? 한번 탈퇴하면 돌이킬 수 없습니다. 그래도 하시겠습니까?") : Text("정말로 로그아웃하시겠습니까?"),
            primaryButton: .cancel(Text("취소")),
            secondaryButton: .destructive(delete ? Text("탈퇴") : Text("로그아웃"), action: {
                if delete{
                    if let authProvier = vmAuth.user?.authProvider{
                        switch authProvier{
                        case "KAKAO":
                            vmAuth.delete(authProvier: "kakao")
                        case "GOOGLE":
                            vmAuth.delete(authProvier: "google")
                        case "NAVER":
                            vmAuth.delete(authProvier: "naver")
                        case "APPLE":
                            vmAuth.delete(authProvier: "apple")
                        default:
                            vmAuth.delete(authProvier: authProvier)
                        }
                    }
                    dismiss()
                }else{
                    dismiss()
                    vmAuth.logout(tokenExpired: false)
                }
            })
        )
    }
}
