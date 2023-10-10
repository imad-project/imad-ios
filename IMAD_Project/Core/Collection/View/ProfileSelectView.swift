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
    @State var loading = false
    @State var tokenExpired = (false,"")
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
                .padding(.bottom)
                LazyVGrid(columns: columns){
                    ForEach(ProfileFilter.allCases,id: \.rawValue){ item in
                        if item != .none{
                            Button {
                                image = item
                            } label: {
                                VStack(spacing: 0) {
                                    Image(item.rawValue)
                                        .resizable()
                                        .frame(width: 100,height: 100)
                                        .overlay {
                                            if image == item{
                                                Color.black.opacity(0.5)
                                            }
                                        }
                                        .cornerRadius(30)
                                    Text(item.name)
                                        .font(.caption)
                                        .foregroundColor(.customIndigo)
                                        
                                }
                                
                            }
                        }
                    }
                }.padding(.horizontal)
                
                Button{
                    
                    vm.profileInfo.profileImage = image.num
                    
                    if vm.profileInfo.nickname == ""{
                        msg = "닉네임을 설정해주세요!"
                        withAnimation(.linear){
                            vm.selection = .nickname
                        }
                        alert = true
                    }else if vm.profileInfo.profileImage == -1{
                        msg = "프로필 이미지를 선택해주세요!"
                        alert = true
                    }else if vm.profileInfo.gender == ""{
                        msg = "성별을 선택해 주세요!"
                        withAnimation(.linear){
                            vm.selection = .gender
                        }
                        alert = true
                    }else{
                        vm.patchUser(gender: vm.profileInfo.gender ?? "", ageRange: vm.profileInfo.ageRange, image: vm.profileInfo.profileImage, nickname: vm.profileInfo.nickname ?? "", tvGenre:vm.profileInfo.tvGenre,movieGenre: vm.profileInfo.movieGenre)
                        vm.selection = .nickname
                        loading = true
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
            if loading{
                Color.gray.opacity(0.5).ignoresSafeArea()
                 CustomProgressView()
            }
        }
        .onReceive(vm.tokenExpired) { messages in
            tokenExpired = (true,messages)
        }
        .alert(isPresented: $tokenExpired.0) {
            Alert(title: Text("토큰 만료됨"),message: Text(tokenExpired.1),dismissButton:.cancel(Text("확인")){
                vm.loginMode = false
            })
        }
    }
}

struct ProfileSelectView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSelectView().environmentObject(AuthViewModel())
    }
}
