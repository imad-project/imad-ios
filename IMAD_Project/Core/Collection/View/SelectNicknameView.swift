//
//  SelectProfileView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/12.
//

import SwiftUI
import PhotosUI

struct SelectNicknameView: View {
    
    @State var temp = ""
    @State var duplicationResult = (possible:false,message:"")  //중복확인 가능 유무
    @State var duplicateConfirm = false
    @StateObject var vmCheck = CheckDataViewModel()
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading){
                Spacer()
                guideView
                checkEmailView
                CustomConfirmButton(text: "다음", color: .customIndigo.opacity(0.5),textColor:.white){ nextAction(false) }
                Spacer()
            }.padding()
        }
        .ignoresSafeArea()
        .foregroundColor(.customIndigo)
        .onReceive(vmCheck.checkResultEvent){ excuteDuplication($0) }
        .onDisappear{nextAction(true)}
        .alert(isPresented: $vmAuth.check.nickname){ alert }
    }
}

struct SelectNicknameView_Previews: PreviewProvider {
    static var previews: some View {
        SelectNicknameView().environmentObject(AuthViewModel(user:nil))
    }
}

extension SelectNicknameView{
    var alert:Alert{
        let title = Text("닉네임을 제대로 설정 해주세요!")
        let button = Alert.Button.cancel(Text("확인"), action: {
            withAnimation(.linear){ vmAuth.selection = .nickname }})
        return Alert(title: title,dismissButton: button)
    }
    func excuteDuplication(_ event:(Bool,String)){
        duplicationResult = event
        duplicateConfirm = true
    }
    var guideView:some View{
        VStack(alignment: .leading,spacing: 5){
            Text("닉네임을 확인해주세요")
                .font(.GmarketSansTTFMedium(20))
                .bold()
            Text("닉네임은 2~10 글자 사이여야 하며, 특수문자와 공백을 포함할 수 없습니다.")
                .font(.GmarketSansTTFMedium(12))
        }
    }
    var checkEmailView:some View{
        VStack(alignment: .leading){
            Text("\(vmAuth.patchUser.nickname.count)/10글자")
                .padding(.top,20)
                .font(.GmarketSansTTFMedium(12))
            HStack{
                CustomTextField(password: false, image: "person", placeholder: "입력..", color: .gray, style: .rounded, textLimit: 10, text: $vmAuth.patchUser.nickname)
                Button {
                    duplicationAction()
                } label: {
                    Text("중복확인")
                        .font(.GmarketSansTTFMedium(15))
                        .foregroundColor(.white)
                        .padding()
                        .padding(.vertical,5)
                        .background {
                            Color.customIndigo
                        }
                        .cornerRadius(20)
                }
            }
            Text(duplicationResult.message)
                .foregroundColor(duplicationResult.possible ? .green : .red)
                .font(.GmarketSansTTFMedium(12))
                .padding(.horizontal)
        }
    }
    func isVaildInfo()->NicknameCheckFilter{
        let pattern = "^[a-zA-Z0-9가-힣ㄱ-ㅎㅏ-ㅣ]{2,10}+$"
        let nickNameRegex = NSPredicate(format: "SELF MATCHES %@", pattern)
        
        if vmAuth.patchUser.nickname.isEmpty{
            return .emptyInfomation
        }else if !nickNameRegex.evaluate(with: vmAuth.patchUser.nickname){
            return .nicknameFormatError
        }else if !duplicateConfirm{
            return .notConfirmDuplicate
        }else if vmAuth.patchUser.nickname != temp{
            return .changedNickname
        }else{
            return .success
        }
    }
    func duplicationAction(){
        switch isVaildInfo(){
        case .changedNickname,.notConfirmDuplicate,.success:
            vmCheck.checkNickname(nickname: vmAuth.patchUser.nickname)
            temp = vmAuth.patchUser.nickname
        default:
            duplicationResult = (false,isVaildInfo().message)
        }
    }
    func nextAction(_ isSlide:Bool){
        switch isVaildInfo(){
        case .success: 
            withAnimation(.linear){
                vmAuth.check.nickname = false
                vmAuth.selection = .gender
            }
        default:
            duplicationResult = (false,isVaildInfo().message)
            if isSlide{ vmAuth.check.nickname = true }
        }
    }
}
