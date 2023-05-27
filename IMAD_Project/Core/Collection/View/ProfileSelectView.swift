//
//  ProfileSelectView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/26.
//

import SwiftUI

struct ProfileSelectView: View {
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()),GridItem(.flexible())]
    
    @State var image:ProfileFilter = .none
    @State var msg = ""
    @State var alert = false
    @State var title = "오류"
    
    @EnvironmentObject var vm:AuthViewModel
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading,spacing: 5){
                
                Text("프로필을 설정해주세요")
                    .font(.title3)
                    .bold()
                    .padding(.leading)
                Text("설정된 프로필은 언제든지 바꾸실수 있습니다. ")
                    .font(.callout)
                .padding(.leading)
                LazyVGrid(columns: columns){
                    ForEach(ProfileFilter.allCases,id: \.rawValue){ item in
                        if item != .none{
                            Button {
                                image = item
                            } label: {
                                VStack(spacing: 0) {
                                    RoundedRectangle(cornerRadius: 20)
                                        .frame(width: 100,height: 100)
                                        .padding(10)
                                        .overlay(content: {
                                            Image(item.rawValue)
                                                .resizable()
                                                .frame(width: 70,height: 70)
                                        })
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                        .overlay {
                                            if image == item{
                                                RoundedRectangle(cornerRadius: 20)
                                                    .frame(width: 100,height: 100)
                                                    .foregroundColor(.black.opacity(0.3))
                                            }
                                        }
                                    Text(item.name)
                                        .font(.caption)
                                        .foregroundColor(.customIndigo)
                                        
                                }
                                .shadow(radius: 10)
                            }
                        }
                    }
                }.padding(.horizontal)
                
                Button{
                    
                    vm.image = image.num
                    
                    if vm.nickname == ""{
                        msg = "닉네임을 설정해주세요!"
                        withAnimation(.linear){
                            vm.selection = .nickname
                        }
                        alert = true
                    }else if vm.image == -1{
                        msg = "프로필 이미지를 선택해주세요!"
                        alert = true
                    }else if vm.gender == ""{
                        msg = "성별을 선택해 주세요!"
                        withAnimation(.linear){
                            vm.selection = .gender
                        }
                        alert = true
                    }else{
                        vm.patchUser(gender: vm.gender, ageRange: vm.age, image: vm.image, nickname: vm.nickname, genre: "")
                        withAnimation(.default){
                            vm.selection = .nickname
                        }
                    }
                }label:{
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 60)
                        .foregroundColor(.customIndigo)
                        .overlay {
                            Text("완료")
                                .bold()
                                .foregroundColor(.white)
                                .shadow(radius: 20)
                        }
                }
                .padding(30)
                .padding(.bottom)
                .alert(isPresented: $alert) {
                    Alert(title: Text(title),message: Text(msg),dismissButton: .default(Text("확인")){
                    })
                }
            }.foregroundColor(.customIndigo).padding()
        }
    }
}

struct ProfileSelectView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSelectView().environmentObject(AuthViewModel())
    }
}
