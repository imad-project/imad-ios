//
//  ProfileSelectView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/26.
//

import SwiftUI

struct ProfileSelectView: View {
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()),GridItem(.flexible())]
    
    @State var msg = ""
    @State var alert = false
    @State var loading = false
    @EnvironmentObject var vm:AuthViewModel
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading,spacing: 5){
                guideView
                selectProfileView
                CustomNextButton(action: {
                    if vm.patchUser.nickname == ""{
                        noSelect(selection: .nickname, message: "닉네임을 설정해주세요!")
                    }else if vm.patchUser.age == 0{
                        noSelect(selection: .age, message: "나이를 설정해주세요!")
                    }else if vm.patchUser.profileImageCode == 0{
                        noSelect(selection: .profile, message: "프로필 사진을 선택해 주세요!")
                    }else if vm.patchUser.gender == ""{
                        noSelect(selection: .gender, message: "성별을 선택해 주세요!")
                    }else{
                        vm.patchUserInfo()
                        loading = true
                    }
                }, color:vm.patchUser.profileImageCode == 0 ? .customIndigo.opacity(0.5):.customIndigo)
            }.foregroundColor(.customIndigo).padding()
            if loading{
                CustomProgressView()
            }
        }.alert(isPresented: $alert) {
            Alert(title: Text("오류"),message: Text(msg),dismissButton: .default(Text("확인")){
            })
        }
    }
}

struct ProfileSelectView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSelectView().environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
    }
}
extension ProfileSelectView{
    var guideView:some View{
        VStack(alignment: .leading,spacing: 5){
            
            Text("프로필을 설정해주세요")
                .font(.title3)
                .bold()
            Text("설정된 프로필은 언제든지 바꾸실수 있습니다. ")
                .font(.callout)
                .padding(.bottom)
        }.padding(.leading)
    }
    var selectProfileView:some View{
        LazyVGrid(columns: columns){
            ForEach(ProfileFilter.allCases,id: \.rawValue){ item in
                if item != .none{
                    Button {
                        vm.patchUser.profileImageCode = item.num
                    } label: {
                        VStack(spacing: 0) {
                            Image(item.rawValue)
                                .resizable()
                                .frame(width: 100,height: 100)
                                .overlay {
                                    if vm.patchUser.profileImageCode == item.num{
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
    }
    func noSelect(selection:RegisterFilter,message:String){
        msg = message
        if selection != .profile{
            withAnimation(.linear){
                vm.selection = selection
            }
        }
        alert = true
    }
}
