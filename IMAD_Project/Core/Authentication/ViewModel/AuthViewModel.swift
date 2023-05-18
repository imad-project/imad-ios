//
//  AuthViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/06.
//

import Foundation
import Combine
import Alamofire

class AuthViewModel:ObservableObject{
    
    //@Published var loginRes:GetUserInfo? = nil
    @Published var registerRes:RegisterResponse? = nil
    @Published var getUserRes:GetUserInfo? = nil
    
    @Published var patchInfoSuccess = false
    @Published var loginMode = false
    
    @Published var age = 20
    
    @Published var patchUserInfo = PatchUserInfo(nickname: "", gender: nil, ageRange: nil, genre: nil, image: 0)
    
    var registerSuccess = PassthroughSubject<Bool,Never>()
    var loginSuccess = PassthroughSubject<Bool,Never>()
    var getUserSuccess = PassthroughSubject<Bool,Never>()
    var cancelable = Set<AnyCancellable>()
    
    func register(email:String,password:String,authProvider:String){
        AuthApiService.register(email: email, password: password,authProvider:authProvider)
            .sink { completion in
                if let code = self.registerRes?.statusCode,code >= 200 && code <= 300{
                    self.registerSuccess.send(true)
                    print("회원가입 완료 \(completion)")
                }else{
                    self.registerSuccess.send(false)
                    print("회원가입 실패 \(completion)")
                }
            } receiveValue: { receivedValue in
                self.registerRes = receivedValue
            }.store(in: &cancelable)
    }
    func login(email:String,password:String){
        AuthApiService.login(email: email, password: password)
            .sink { completion in
                if let code = self.getUserRes?.status,code >= 200 && code <= 300{
                    print()
                    if self.getUserRes?.data?.nickname == nil{
                        self.patchInfoSuccess = true
                    }
                    self.loginSuccess.send(true)
                    print("로그인 완료 \(completion)")
                }else{
                    self.loginSuccess.send(false)
                    print("로그인 실패 \(completion)")
                }
            } receiveValue: { receivedValue in
                self.getUserRes = receivedValue
            }.store(in: &cancelable)
    }
//    func oauth(registrationId:String){
//        AuthApiService.oauth(registrationId: registrationId)
//            .sink { completion in
//                print("로그인 완료 \(completion)")
//                self.oauthSuccess.send()
//            } receiveValue: { receivedValue in
//                self.oauthRes = receivedValue
//            }.store(in: &cancelable)
//    }
    func getUser(){
        UserApiService.user(userId: 2)
            .sink { completion in
                if let code = self.getUserRes?.status,code >= 200 && code <= 300{
                    self.loginMode = true
                    if self.getUserRes?.data?.nickname == nil{
                        self.patchInfoSuccess = true
                    }
                    print("유저정보 수신 완료 \(completion)")
                }else{
                    print("유저정보 수신 실패 \(completion)")
                }
            } receiveValue: { receivedValue in
                self.getUserRes = receivedValue
            }.store(in: &cancelable)

    }
    func patchUser(){
        UserApiService.patchUser(gender: patchUserInfo.gender, ageRange: patchUserInfo.ageRange, image: patchUserInfo.image, nickname: patchUserInfo.nickname, genre: patchUserInfo.genre, userId: 2)
            .sink { completion in
                if let code = self.getUserRes?.status,code >= 200 && code <= 300{
                    self.getUserSuccess.send(true)
                    print("유저정보 수신 완료 \(completion)")
                }else{
                    self.getUserSuccess.send(false)
                    print("유저정보 수신 실패 \(completion)")
                }
            } receiveValue: { receivedValue in
                self.getUserRes = receivedValue
            }.store(in: &cancelable)
    }
    func logout(){
        loginMode = false
        UserDefaultManager.shared.clearAll()
    }
}
