//
//  ProfileSelectView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/12.
//

import SwiftUI
import PhotosUI

struct ProfileSelectView: View {
    
    @State private var selectedImageData: Data? = nil
    @State private var selectedItem: PhotosPickerItem? = nil
    @Binding var register:Bool
    
    var body: some View {
        ZStack{
            BackgroundView(height: 0.83, height1: 0.9)
            VStack{
                Spacer()
                Text("3. 프로필 사진을 설정해주세요")
                    .bold()
                    .padding(.bottom,50)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.leading)
                    .padding(.bottom,50)
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
                                    Circle().stroke(lineWidth: 5)
                                        .frame(width: 200,height: 200)
                                        .overlay{
                                            Image(systemName: "photo")
                                                .resizable()
                                                .frame(width: 100,height: 100)
                                            
                                        }
                                }
                            }
                            
                        }.onChange(of: selectedItem) { newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    selectedImageData = data
                                }
                            }
                        }
               
                Button{
                    register.toggle()
                }label:{
                    Capsule()
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .overlay {
                            Text("완료")
                                .bold()
                                .foregroundColor(.customIndigo)
                                .shadow(radius: 20)
                        }
                }
                .padding(50)
                Spacer()
            }
        }
        .foregroundColor(.white)
    }
}

struct ProfileSelectView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSelectView(register: .constant(false))
    }
}
