//
//  AuthViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/06.
//

import Foundation
import Combine
import Alamofire
import AuthenticationServices


final class AuthViewModel:ObservableObject{
    
    
    @Published var selection:RegisterFilter = .nickname     //탭뷰
    @Published var patchUser:PatchUserInfo = PatchUserInfo(user: nil)
    @Published var message = ""
    
    var success = PassthroughSubject<(),Never>()
    
    var registerSuccess = PassthroughSubject<Bool,Never>()
    var loginSuccess = PassthroughSubject<String,Never>()
    var cancelable = Set<AnyCancellable>()
    
    func register(email:String,password:String,authProvider:String){
        AuthApiService.register(email: email, password: password,authProvider:authProvider)
            .sink{ completion in
                print(completion)
            } receiveValue: { [weak self] noData in
                self?.message = noData.message
                self?.registerSuccess.send((200..<300)~=noData.status ? true : false)
            }.store(in: &cancelable)
    }
    func login(email:String,password:String){
        AuthApiService.login(email: email, password: password)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] user in
                UserInfoCache.instance.user = user
                self?.loginSuccess.send(user.message)
            }.store(in: &cancelable)
    }
    func getUser(){
        UserApiService.user()
            .sink { completion in
                ErrorManager.instance.actionErrorMessage(completion: completion, success: {}, failed: {self.logout(tokenExpired: true)})
            } receiveValue: { [weak self] user in
                UserInfoCache.instance.user = user
                self?.patchUser = PatchUserInfo(user: user.data)
            }.store(in: &cancelable)
    }
    func patchUserInfo(){
        UserApiService.patchUser(gender: patchUser.gender, birthYear: patchUser.age, nickname: patchUser.nickname, tvGenre: patchUser.tvGenre,movieGenre: patchUser.movieGenre)
            .sink { completion in
                ErrorManager.instance.actionErrorMessage(completion: completion, success: {}, failed: {self.logout(tokenExpired: true)})
            } receiveValue: { [weak self] user in
                UserInfoCache.instance.user = user
                self?.patchUser = PatchUserInfo(user: user.data)
            }.store(in: &cancelable)
    }
    func logout(tokenExpired:Bool){
        print("로그아웃 및 토큰 삭제")
        message = ""
        UserInfoCache.instance.user = nil
        patchUser = PatchUserInfo(user: nil)
        selection = .nickname
        UserDefaultManager.shared.clearAll()
    }
    func delete(authProvier:String){
        AuthApiService.delete(authProvier:authProvier)
            .sink { completion in
                ErrorManager.instance.actionErrorMessage(completion: completion, success: {}, failed: {self.logout(tokenExpired: true)})
            } receiveValue: { [weak self] noData in
                self?.message = noData.message
            }.store(in: &cancelable)
    }
    func passwordChange(old:String,new:String){
        UserApiService.passwordChange(old: old, new: new)
            .sink { completion in
                ErrorManager.instance.actionErrorMessage(completion: completion, success: {}, failed: {self.logout(tokenExpired: true)})
            } receiveValue: { [weak self] noData in
                self?.message = noData.message
            }.store(in: &cancelable)
    }
    func appleLogin(result: Result<ASAuthorization, any Error>){
        switch result {
        case .success(let authResults):
            switch authResults.credential{
            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                let state = appleIDCredential.state
                let IdentityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8) ?? ""
                let userIdentifier = appleIDCredential.user
                let authoriztaion = String(data: appleIDCredential.authorizationCode!, encoding: .utf8) ?? ""
                AuthApiService.appleLogin(authorizationCode: authoriztaion, userIdentity: userIdentifier, state: state, idToken: IdentityToken){ saveTokenSuccess in
                    guard saveTokenSuccess else {return self.loginSuccess.send("로그인에 실패했습니다.")}
                    self.getUser()
                }
            default:  break
            }
        case .failure(let error):
            print(error.localizedDescription)
            print("error")
        }
    }
    
}
