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

    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        NavigationView {
            VStack(spacing:10){
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.leading)
                .foregroundColor(.primary)
                .padding(.top,50)
                Text("프로필 변경")
                    .font(.title)
                    .bold()
                    .padding()
                    
                PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()) {
                            Group{
                                if let selectedImageData,
                                   let uiImage = UIImage(data: selectedImageData) {
                                            Image(uiImage: uiImage)
                                            .resizable()
                                            .frame(width: 200,height: 200)
                                            .clipShape(Circle())
                                        }
                                else{
                                    KFImage(URL(string: CustomData.instance.userReiveList.last!.image))
                                        .resizable()
                                        .frame(width: 200,height: 200)
                                        .clipShape(Circle())
                                }
                            }
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
                            
                        }.onChange(of: selectedItem) { newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    selectedImageData = data
                                }
                            }
                        }
                
                Text("quarang.__")
                    .bold()
                    .font(.title3)
                Text(verbatim:"dbduddnd1225@gmail.com")
                    .padding(.bottom,20)
                
                List{
                    Group{
                        NavigationLink {
                            InfoChangeView(title: "닉네임", password: false, text: "quarnag.__")
                                
                        } label: {
                            Text("닉네임 변경")
                        }
                        NavigationLink {
                            InfoChangeView(title: "이메일", password: false, text: "dbduddnd1225@gmail.com")
                               
                        } label: {
                            Text("이메일 변경")
                        }
                        NavigationLink {
                            InfoChangeView(title: "비밀번호", password: true, text: "hero1225")
                              
                        } label: {
                            Text("비밀번호 변경")
                        }
                    }
                    .listRowBackground(Color.clear)
                    
                }
                .scrollContentBackground(.hidden)
                .listStyle(.plain)
            }
            .background{
                ZStack{
                    Color.antiPrimary
                    ProfileView(login: .constant(true))
                        .blur(radius: 20)
                        .opacity(0.1)

                }.ignoresSafeArea()
            }
            
            
        }
        .foregroundColor(.primary)
        
    }
}

struct ProfileChangeView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileChangeView()
    }
}
