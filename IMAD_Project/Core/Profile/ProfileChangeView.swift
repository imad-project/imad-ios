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
    @State private var selectedImageData: Data? = nil
    @State private var selectedItem: PhotosPickerItem? = nil
    @State var profileImage = ""
    @State var profileSelect = false
    @State var imageCode:ProfileFilter = .none
    
    let colums = [GridItem(.flexible()),GridItem(.flexible())]
    @EnvironmentObject var vmAuth:AuthViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            ZStack{
                HStack{
                    Button {
                        if profileSelect{
                            withAnimation(.easeIn(duration:0.5)){
                                profileSelect = false
                            }
                        }else{
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "xmark")
                    }
                    Spacer()
                    if profileSelect{
                        Button {
                            print(vmAuth.age)
                            print(vmAuth.gender)
                            print(vmAuth.nickname)
                            print(imageCode.num)
                            vmAuth.patchUser(gender: vmAuth.gender, ageRange: vmAuth.age, image:imageCode.num, nickname: vmAuth.nickname, genre: "")
                            dismiss()
                        } label: {
                            Text("완료")
                        }
                    }
                }
                .frame(maxHeight: .infinity,alignment: .top)
                .padding(.horizontal)
                .foregroundColor(.primary)
                .padding(.top,50)
                
                VStack(spacing:10){
                    if !profileSelect{
                        Text("프로필 변경")
                            .font(.title)
                            .bold()
                            .padding()
                            .padding(.top,100)
                        Button {
                            withAnimation(.easeIn(duration:0.5)){
                                profileSelect = true
                            }
                        } label: {
                            Group{
                                if profileImage != ""{
                                    Image(profileImage)
                                        .resizable()
                                        .overlay {
                                            Image(vmAuth.getUserRes?.data?.gender ?? "")
                                                .resizable()
                                                .frame(width: 150, height: 120)
                                        }
                                        
                                }else{
                                    Circle()
                                }
                            }
                            .frame(width: 200,height: 200)
                            .overlay(alignment:.bottomTrailing){
                                Circle()
                                    .foregroundColor(.black.opacity(0.7))
                                    .frame(width: 50,height: 50)
                                    .overlay {
                                        Image(systemName: "photo")
                                            .foregroundColor(.white)
                                    }
                                    .padding([.bottom,.trailing],5)
                            }
                        }
                        Text("\(vmAuth.getUserRes?.data?.nickname ?? "")")
                            .bold()
                            .font(.title3)
                        Text(verbatim:"\(vmAuth.getUserRes?.data?.email ?? "")")
                            .padding(.bottom,20)
                        
                        List{
                            Group{
                                NavigationLink {
                                    InfoChangeView(title: "닉네임", password: false, text: vmAuth.getUserRes?.data?.nickname ?? "").environmentObject(vmAuth)
                                        
                                } label: {
                                    Text("닉네임 변경")
                                }
                                NavigationLink {
                                    InfoChangeView(title: "이메일", password: false, text: "")
                                        .environmentObject(vmAuth)
                                       
                                } label: {
                                    Text("이메일 변경")
                                }
                                NavigationLink {
                                    InfoChangeView(title: "비밀번호", password: true)
                                        .environmentObject(vmAuth)
                                      
                                } label: {
                                    Text("비밀번호 변경")
                                }
                            }
                            .listRowBackground(Color.clear)
                            
                        }
                        .scrollContentBackground(.hidden)
                        .listStyle(.plain)
                        Spacer()
                    }else{
                        Text("프로필 선택")
                            .font(.title)
                            .bold()
                            .padding()
                            .padding(.bottom,50)
                        LazyVGrid(columns: colums,spacing: 30) {
                            ForEach(ProfileFilter.allCases,id:\.rawValue){ item in
                                if item != .none{
                                    Button {
                                        imageCode = item
                                    } label: {
                                        Image(item.rawValue)
                                            .resizable()
                                            .frame(width: 150,height: 150)
                                            .overlay {
                                                Image(vmAuth.getUserRes?.data?.gender ?? "")
                                                    .resizable()
                                                    .frame(width: 100, height: 80)
                                                if imageCode == item{
                                                    Circle()
                                                        .foregroundColor(.black.opacity(0.7))
                                                }
                                            }
                                    }
                                }
                            }
                        }
                    }
                    
                }
            }
            .background{
                ZStack{
                    Color.antiPrimary
                    ProfileView()
                        .allowsHitTesting(false)
                        .blur(radius: 20)
                        .opacity(0.1)

                }.ignoresSafeArea()
            }
        }
        .foregroundColor(.primary)
        .onAppear{
            for image in ProfileFilter.allCases{
                if let imageCode = vmAuth.getUserRes?.data?.profileImage,imageCode == image.num{
                    profileImage = image.rawValue
                    self.imageCode = image
                }
            }
        }
    }
}

struct ProfileChangeView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileChangeView()
            .environmentObject(AuthViewModel())
    }
}
