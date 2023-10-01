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
    
    
    @Published var registerRes:RegisterResponse? = nil
    @Published var getUserRes:GetUserInfo? = nil
    @Published var passwordChangeRes:GetUserInfo? = nil
    @Published var selection:RegisterFilter = .nickname     //탭뷰
    
    @Published var getTokenCnt = 0
    
    @Published var guestMode = false
    @Published var loginMode = false
    
    @Published var age = 20
    @Published var nickname = ""
    @Published var image = -1
    @Published var gender = ""
    @Published var movieGenre:[Int] = []
    @Published var tvGenre:[Int] = []
    
    var registerSuccess = PassthroughSubject<Bool,Never>()
    var loginSuccess = PassthroughSubject<Bool,Never>()
    var getUserSuccess = PassthroughSubject<Bool,Never>()
    var patchInfoSuccess = PassthroughSubject<Bool,Never>()
    var deleteSuccess = PassthroughSubject<Bool,Never>()
    var passwordChangeSuccess = PassthroughSubject<(),Never>()
    var cancelable = Set<AnyCancellable>()
    
    
    func register(email:String,password:String,authProvider:String){
        AuthApiService.register(email: email, password: password,authProvider:authProvider)
            .sink { completion in
                if let code = self.registerRes?.statusCode,code >= 200 && code <= 300{
                    self.registerSuccess.send(true)
                    self.guestMode = true
                    print("회원가입 완료 \(completion)")
                }else{
                    self.registerSuccess.send(false)
                    print("회원가입 실패 \(completion)")
                }
            } receiveValue: { [weak self] receivedValue in
                self?.registerRes = receivedValue
            }.store(in: &cancelable)
    }
    func login(email:String,password:String){
        AuthApiService.login(email: email, password: password)
            .sink { completion in
                if let code = self.getUserRes?.status,code >= 200 && code <= 300{
                    if self.getUserRes?.data?.role == "GUEST"{
                        self.guestMode = true
                    }
                    self.age = self.getUserRes?.data?.ageRange ?? -1
                    self.nickname = self.getUserRes?.data?.nickname ?? ""
                    self.gender = self.getUserRes?.data?.gender ?? ""
                    self.image = self.getUserRes?.data?.profileImage ?? -1
                    self.loginSuccess.send(true)
                    print("로그인 완료 \(completion)")
                }else{
                    self.loginSuccess.send(false)
                    print("로그인 실패 \(completion)")
                }
            } receiveValue: { [weak self] receivedValue in
                self?.getUserRes = receivedValue
            }.store(in: &cancelable)
    }
    func getUser(){
        UserApiService.user()
            .sink { completion in
                if let code = self.getUserRes?.status,code >= 200 && code <= 300{
                    self.loginMode = true
                    if self.getUserRes?.data?.role == "GUEST"{
                        self.guestMode = true
                    }
                    self.age = self.getUserRes?.data?.ageRange ?? -1
                    self.nickname = self.getUserRes?.data?.nickname ?? ""
                    self.gender = self.getUserRes?.data?.gender ?? ""
                    self.image = self.getUserRes?.data?.profileImage ?? -1
                    print("유저정보 수신 완료 \(completion)")
                }else{
                    print("유저정보 수신 실패 \(completion)")
                    if let errorMsg = self.getUserRes?.message,errorMsg == "토큰의 기한이 만료되었습니다."{
                        AuthApiService.getToken()
                        self.getTokenCnt += 1
                        print("토큰 재발급")
                        if self.getTokenCnt < 2{
                            self.getUser()
                        }
                    }
                }
            } receiveValue: { [weak self] receivedValue in
                self?.getUserRes = receivedValue
            }.store(in: &cancelable)

    }
    func patchUser(gender:String?,ageRange:Int?,image:Int,nickname:String,genre:String?){
        UserApiService.patchUser(gender: gender, ageRange: ageRange, image: image, nickname: nickname, genre: genre)
            .sink { completion in
                self.patchInfoSuccess.send(true)
                if let code = self.getUserRes?.status,code >= 200 && code <= 300{
                    print("유저정보 수정 완료 \(completion)")
                    self.image = self.getUserRes?.data?.profileImage ?? 0
                    self.gender = self.getUserRes?.data?.gender ?? ""
                    self.age = self.getUserRes?.data?.ageRange ?? 0
                    self.nickname = self.getUserRes?.data?.nickname ?? ""
                    
                }else{
                    print("유저정보 수정 실패 \(completion)")
                }
            } receiveValue: { [weak self] receivedValue in
                self?.getUserRes = receivedValue
            }.store(in: &cancelable)
    }
    func logout(){
        print("로그아웃 및 토큰 삭제")
        loginMode = false
        UserDefaultManager.shared.clearAll()
    }
    func delete(authProvier:String){
        AuthApiService.delete(authProvier:authProvier)
            .sink { completion in
                if let code = self.getUserRes?.status,code >= 200 && code <= 300{
                    self.deleteSuccess.send(true)
                    self.loginMode = false
                    UserDefaultManager.shared.clearAll()
                    print("회원탈퇴 완료 \(completion)")
                }else{
                    print("회원탈퇴 실패 \(completion)")
                }
            } receiveValue: { [weak self] receivedValue in
                self?.getUserRes = receivedValue
            }.store(in: &cancelable)
        
    }
    func passwordChange(old:String,new:String){
        UserApiService.passwordChange(old: old, new: new)
            .sink { completion in
                if let code = self.passwordChangeRes?.status,code >= 200 && code <= 300{
                    self.passwordChangeSuccess.send()
                    print("회원탈퇴 완료 \(completion)")
                }else{
                    print("회원탈퇴 실패 \(completion)")
                }
            } receiveValue: { [weak self] receivedValue in
                self?.passwordChangeRes = receivedValue
            }.store(in: &cancelable)

    }
}
