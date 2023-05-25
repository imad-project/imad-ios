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
    @State var text = ""
   
    let columns = [GridItem(.flexible()), GridItem(.flexible()),GridItem(.flexible())]
    
    @State var image:ProfileFilter = .none
    @State var msg = ""
    @State var alert = false
    @State var title = "오류"
    //@Binding var register:Bool
    
    @EnvironmentObject var vm:AuthViewModel
    
    var body: some View {
        ZStack{
            BackgroundView(height: 0.83, height1: 0.87,height2: 0.85,height3: 0.86)
            VStack{
                Spacer()
                Text("3. 닉네임과 프로필 사진을 설정해주세요")
                    .bold()
                    .padding(.bottom,50)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.leading)
               
                HStack(spacing: 0){
                    Text("• 닉네임을 설정해주세요 ")
                    Text("(필수)").bold()
                }
                
                .padding(.leading,30)
                .frame(maxWidth: .infinity,alignment: .leading)
                CustomTextField(password: false, image: "person", placeholder: "입력..", color: .white, text: $text)
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(10)
                    .padding(.horizontal,30)
                    .padding(.bottom,20)
                    .padding(.vertical,10)
                HStack(spacing: 0){
                    Text("• 마음에 드는 프로필을 선택해주세요 ")
                    Text("(필수)").bold()
                }
                
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.leading,30)
                LazyVGrid(columns: columns){
                    ForEach(ProfileFilter.allCases,id: \.rawValue){ item in
                        if item != .none{
                            Button {
                                image = item
                            } label: {
                                Image(item.rawValue)
                                    .resizable()
                                    .frame(width: 120,height: 120)
                                    .background(Circle().foregroundColor(.white))
                                    .padding(5)
                                    .overlay {
                                        Image(vm.gender)
                                            .resizable()
                                            .frame(width: 100,height: 80)
                                            .shadow(radius: 20)
                                        if image == item{
                                            Circle()
                                                .frame(width: 120,height: 120)
                                                .foregroundColor(.black.opacity(0.7))
                                        }
                                    }
                            }
                        }
                    }
                }.padding(.horizontal)
                
                Button{
                    vm.nickname = text
                    vm.age = vm.age/10
                    vm.image = image.num
                    
                    if vm.nickname == ""{
                        msg = "닉네임을 설정해주세요!"
                        alert = true
                    }else if vm.image == -1{
                        msg = "프로필 이미지를 선택해주세요!"
                        alert = true
                    }else if vm.gender == ""{
                        msg = "성별을 선택해 주세요!"
                        alert = true
                    }else{
                        vm.patchUser(gender: vm.gender, ageRange: vm.age, image: vm.image, nickname: vm.nickname, genre: "")
                    }
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
                .padding(.bottom)
                .alert(isPresented: $alert) {
                    Alert(title: Text(title),message: Text(msg),dismissButton: .default(Text("확인")){
                    })
                }
            }.ignoresSafeArea(.keyboard)
        }
        .foregroundColor(.white)
    }
}

struct ProfileSelectView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSelectView().environmentObject(AuthViewModel())
    }
}
