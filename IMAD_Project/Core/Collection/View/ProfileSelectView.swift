//
//  ProfileSelectView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/26.
//

import SwiftUI

struct ProfileSelectView: View {
    
    // - 알람 메세지 혹은 로딩 화면 관련
    @State var msg = ""
    @State var alert = false
    @State var loading = false
    // - 프사관련
    @State var showPicker = false
    @State var croppedImage:UIImage?
    @StateObject var vmProfile = ProfileImageViewModel()
    @EnvironmentObject var vm:AuthViewModel
    
    var body: some View {
        ZStack{
            if loading{
                CustomProgressView()
            }else{
                Color.white.ignoresSafeArea()
                VStack(alignment: .leading,spacing: 5){
                    guideView
                    if let croppedImage{
                        Image(uiImage: croppedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200,height: 200)
                            .clipShape(Circle())
                            .shadow(radius: 1)
                            .frame(maxWidth: .infinity)
                    }else{
                        Image(vmProfile.defaultImage.rawValue)
                            .resizable()
                            .frame(width: 200, height: 200)
                            .background{
                                Circle()
                                    .foregroundColor(.white)
                                    .shadow(color: vmProfile.defaultImage.color,radius: 1)
                            }
                            .frame(maxWidth: .infinity)
                    }
                    selectProfileView
                    CustomNextButton(action: {
                        if vm.patchUser.nickname == ""{
                            noSelect(selection: .nickname, message: "닉네임을 설정해주세요!")
                        }else if vm.patchUser.gender == ""{
                            noSelect(selection: .gender, message: "성별을 선택해 주세요!")
                        }else{
                            vm.patchUserInfo()
                            if let image = vmProfile.customImage,vmProfile.defaultImage == .none{
                                vmProfile.fetchProfileImageCustom(image: image)
                            }else{
                                vmProfile.fetchProfileImageDefault(image: vmProfile.defaultImage.num.getImageValue())
                            }
                            loading = true
                        }
                    }, color:vm.patchUser.nickname.isEmpty || vm.patchUser.gender.isEmpty ? .customIndigo.opacity(0.5):.customIndigo)
                }
                .foregroundColor(.customIndigo)
                
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
                .font(.GmarketSansTTFMedium(20))
                .bold()
            Text("설정된 프로필은 언제든지 바꾸실수 있습니다. ")
                .font(.GmarketSansTTFMedium(15))
                .padding(.bottom)
        }.padding(.leading)
    }
    var selectProfileView:some View{
        ScrollView(.horizontal,showsIndicators: false){
            HStack{
                selectProfileButton
                ForEach(ProfileFilter.allCases,id: \.rawValue){ profile in
                    if profile != .none{
                        Button {
                            vmProfile.defaultImage = profile
                            vmProfile.customImage = nil
                            croppedImage = nil
                        } label: {
                            ZStack{
                                Circle()
                                    .frame(width: 100,height: 100)
                                    .shadow(color:profile.color,radius: 1)
                                    .foregroundColor(.white)
                                Image(profile.rawValue)
                                    .resizable()
                                    .frame(width: 100,height: 100)
                                Circle()
                                    .frame(width: 100,height: 100)
                                    .foregroundColor(vmProfile.defaultImage == profile ? .black.opacity(0.5) : .clear)
                                        
                            }
                            .padding(.bottom,25)
                            .padding(.horizontal,5)
                        }
                        
                    }
                }
            }.padding()
        }
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
    
    var selectProfileButton:some View{
        Button {
            showPicker = true
        } label: {
            VStack{
                Circle()
                    .stroke(lineWidth: 2)
                    .frame(width: 100,height: 100)
                    .overlay {
                        Image(systemName: "camera")
                            .font(.largeTitle)
                    }
                    .foregroundColor(.black.opacity(0.8))
                
                Text("프로필 선택")
                    .font(.GmarketSansTTFMedium(15))
                    .foregroundColor(.customIndigo)
            }
        }
        .cropImagePicker(show: $showPicker, croppedImage: $croppedImage)
        .onChange(of: croppedImage) { value in
            if let value{
                vmProfile.defaultImage = .none
                let image = value.resize(targetSize: CGSize(width: 128, height: 128))
                let renderer = ImageRenderer(content: Image(uiImage: image))
                if let imageData = renderer.uiImage?.jpegData(compressionQuality: 1.0) {
                    vmProfile.customImage = imageData
                }
            }
        }
        .padding(.trailing,5)
    }
}
