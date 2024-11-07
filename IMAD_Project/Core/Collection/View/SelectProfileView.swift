//
//  SelectProfileView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/26.
//

import SwiftUI

struct SelectProfileView: View {
    
    
    // - 알람 메세지 혹은 로딩 화면 관련
    @State var faildProfileImageUpload = (alert:false,message:"")
    @State var loading = false
    // - 프사관련
    @State var showPicker = false
    @State var croppedImage:UIImage?
    @StateObject var vmProfile = ProfileImageViewModel()
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var body: some View {
        VStack(alignment: .leading,spacing: 5){
            guideView
            selectedProfileView
            selectProfileView
            confirmButton
        }
        .background(.white)
        .foregroundColor(.customIndigo)
        .alert(isPresented: .constant(faildProfileImageUpload.alert)){alert}
        .progress(!loading)
        .onReceive(vmProfile.isSuccessProfileChanged){  vmAuth.patchUserInfo() }
        .onReceive(vmProfile.isFailedProfileChanged){ faildProfileImageUpload = $0 }
    }
}

struct SelectProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SelectProfileView()
            .environmentObject(AuthViewModel(user: CustomData.user))
    }
}
extension SelectProfileView{
    var alert:Alert{
        let title = Text("오류")
        let message = Text(faildProfileImageUpload.message)
        let button = Alert.Button.default(Text("확인"))
        return Alert(title:title,message:message,dismissButton: button)
    }
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
    @ViewBuilder
    var selectedProfileView:some View{
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
    }
    var selectProfileView:some View{
        ScrollView(.horizontal,showsIndicators: false){
            HStack{
                selectProfileButton
                ForEach(ProfileFilter.allCases,id: \.rawValue){ profile in
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
                    .conditionAppear(profile != .none)
                }
            }
            .padding()
        }
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
            guard let value else { return }
            vmProfile.defaultImage = .none
            let image = value.resize(targetSize: CGSize(width: 128, height: 128))
            let renderer = ImageRenderer(content: Image(uiImage: image))
            guard let imageData = renderer.uiImage?.jpegData(compressionQuality: 1.0) else { return }
            vmProfile.customImage = imageData
        }
        .padding(.trailing,5)
    }
    var confirmButton:some View{
        CustomConfirmButton(text: "완료", color: vmAuth.patchUser.nickname.isEmpty || vmAuth.patchUser.gender.isEmpty ? .customIndigo.opacity(0.5):.customIndigo,textColor:.white) {
            if let image = vmProfile.customImage,vmProfile.defaultImage == .none{
                vmProfile.fetchProfileImageCustom(image: image)
                loading = true
            }else{
                vmProfile.fetchProfileImageDefault(image: vmProfile.defaultImage.num.getImageValue())
                loading = true
            }
        }
        .padding(.horizontal)
    }
}
