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
    @State var profileSelect = false
    @State var imageCode:ProfileFilter = .none
    @State var delete = false
    @State var logout = false
    
    
    @EnvironmentObject var vmAuth:AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
                VStack(spacing:10){
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
                        List{
                            Group{
                                NavigationLink {
                                    InfoChangeView(title: "닉네임", password: false, text: vmAuth.getUserRes?.data?.nickname ?? "").environmentObject(vmAuth)
                                        
                                } label: {
                                    Text("닉네임 변경")
                                }
                                NavigationLink {
                                    InfoChangeView(title: "성별", password: false, text: "")
                                        .environmentObject(vmAuth)
                                } label: {
                                    Text("성별 변경")
                                }
                                NavigationLink {
                                    InfoChangeView(title: "나이", password: false, text: "")
                                        .environmentObject(vmAuth)
                                } label: {
                                    Text("나이 변경")
                                }
                                if vmAuth.getUserRes?.data?.authProvider == "IMAD"{
                                    NavigationLink {
                                        InfoChangeView(title: "비밀번호", password: true)
                                            .environmentObject(vmAuth)
                                          
                                    } label: {
                                        Text("비밀번호 변경")
                                    }
                                }
                                Button {
                                    logout = true
                                    delete = false
                                } label: {
                                    Text("로그아웃")
                                }

                                Button {
                                    logout = true
                                    delete = true
                                } label: {
                                    Text("회원탈퇴")
                                        .foregroundColor(.red)
                                }
                            }
                            .listRowBackground(Color.clear)
                           
                        }
                        .scrollContentBackground(.hidden)
                        .listStyle(.plain)
                        Spacer()
                    
                    
                }
        }
        .navigationBarBackButtonHidden()
        .foregroundColor(.black)
        .alert(isPresented: $logout) {
            Alert(
                title: delete ? Text("회원탈퇴"): Text("로그아웃"),
                message: delete ? Text("정말로 회원을 탈퇴하시겠습니까? 한번 탈퇴하면 돌이킬 수 없습니다. 그래도 하시겠습니까?") : Text("정말로 로그아웃하시겠습니까?"),
                primaryButton: .cancel(Text("취소")),
                secondaryButton: .destructive(delete ? Text("탈퇴") : Text("로그아웃"), action: {
                    if delete{
                        dismiss()
                        vmAuth.delete()
                    }else{
                        dismiss()
                        vmAuth.logout()
                    }
                })
            )
        }
    }
}

struct ProfileChangeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileChangeView()
                .environmentObject(AuthViewModel())
        }
        
    }
}
