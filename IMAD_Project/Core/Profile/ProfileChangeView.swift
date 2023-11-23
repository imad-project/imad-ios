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
    @State var phase:CGFloat = 0.0
   // @State var profileImage = ""
    
    
    @State var delete = false
    @State var logout = false
//    @State var tokenExpired = (false,"")
    
    @EnvironmentObject var vmAuth:AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
                VStack(spacing:10){
                   header
                        List{
                            Group{
                                navigatoionChangeView(view: InfoChangeView(title: "닉네임", password: false, text:vmAuth.user?.data?.nickname ?? ""), text: "닉네임 변경")
                                navigatoionChangeView(view: InfoChangeView(title: "성별", password: false,gender: vmAuth.user?.data?.gender ?? ""), text: "성별 변경")
                                navigatoionChangeView(view: InfoChangeView(title: "나이", password: false,age: vmAuth.user?.data?.ageRange ?? 0), text: "나이 변경")
                                if vmAuth.user?.data?.authProvider == "IMAD"{
                                    navigatoionChangeView(view: InfoChangeView(title: "비밀번호", password: true), text: "비밀번호 변경")
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
                            .listRowBackground(Color.clear)
                           
                        }
                        .scrollContentBackground(.hidden)
                        .listStyle(.plain)
                        Spacer()
                    
                    
                }
        }
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
                .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
        }
        
    }
}

extension ProfileChangeView{
    var header:some View{
        ZStack(alignment: .top){
            Text("개인 정보 변경")
                .bold()
            HStack{
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
                Spacer()
            }
        }.padding(.horizontal)
            .padding(.bottom)
    }
    func navigatoionChangeView(view:some View,text:String) -> some View{
        NavigationLink {
            view
                .environmentObject(vmAuth)
                .navigationBarBackButtonHidden()
        } label: {
            Text(text)
        }
    }
    func actionButtonView(action:@escaping () -> (),text:String) -> some View{
        Button (action:action){
            Text(text)
        }
    }
    func alert() -> Alert{
        Alert(
            title: delete ? Text("회원탈퇴"): Text("로그아웃"),
            message: delete ? Text("정말로 회원을 탈퇴하시겠습니까? 한번 탈퇴하면 돌이킬 수 없습니다. 그래도 하시겠습니까?") : Text("정말로 로그아웃하시겠습니까?"),
            primaryButton: .cancel(Text("취소")),
            secondaryButton: .destructive(delete ? Text("탈퇴") : Text("로그아웃"), action: {
                if delete{
                    if let authProvier = vmAuth.user?.data?.authProvider{
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
