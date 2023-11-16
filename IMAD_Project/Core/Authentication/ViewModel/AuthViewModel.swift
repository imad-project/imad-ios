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
    
    
    @Published var selection:RegisterFilter = .nickname     //탭뷰
    @Published var patchUser:PatchUserInfo = PatchUserInfo(user: nil)
    @Published var message = ""
    @Published var user:UserInfo? = nil
    
    @Published var tokenExpiredMessage = ""
    
    var success = PassthroughSubject<(),Never>()
    
    var registerSuccess = PassthroughSubject<Bool,Never>()
    var loginSuccess = PassthroughSubject<String,Never>()
    var cancelable = Set<AnyCancellable>()
    
    init(user: UserInfo?) {
        self.user = user
    }
    
    func register(email:String,password:String,authProvider:String){
        AuthApiService.register(email: email, password: password,authProvider:authProvider)
            .sink{ completion in
                print(completion)
                self.success.send()
            } receiveValue: { [weak self] noData in
                self?.message = noData.message
                switch noData.status{
                case 200..<300:
                    self?.registerSuccess.send(true)
                default:
                    self?.registerSuccess.send(false)
                }
            }.store(in: &cancelable)
    }
    func login(email:String,password:String){
        AuthApiService.login(email: email, password: password)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] user in
                self?.user = user
                switch user.status{
                case 200..<300:
                    self?.loginSuccess.send(user.message)
                default:
                    self?.loginSuccess.send(user.message)
                }
            }.store(in: &cancelable)
    }
    func getUser(){
        UserApiService.user()
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.logout(tokenExpired: true)
                case .finished:
                    print(completion)
                }
            } receiveValue: { [weak self] user in
                self?.user = user
                self?.patchUser = PatchUserInfo(user: user.data)
            }.store(in: &cancelable)
    }
    func patchUserInfo(){
        UserApiService.patchUser(gender: patchUser.gender, ageRange: patchUser.age, image: patchUser.profileImageCode, nickname: patchUser.nickname, tvGenre: patchUser.tvGenre,movieGenre: patchUser.movieGenre)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.logout(tokenExpired: true)
                case .finished:
                    print(completion)
                }
            } receiveValue: { [weak self] user in
                self?.user = user
                self?.patchUser = PatchUserInfo(user: user.data)
            }.store(in: &cancelable)
    }
    func logout(tokenExpired:Bool){
        print("로그아웃 및 토큰 삭제")
        self.tokenExpiredMessage = tokenExpired ? "토큰이 만료 되었습니다.\n다시 로그인 해주세요" : "로그인이 완료 되었습나다."
        user = nil
        UserDefaultManager.shared.clearAll()
    }
    func delete(authProvier:String){
        AuthApiService.delete(authProvier:authProvier)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.logout(tokenExpired: true)
                case .finished:
                    print(completion)
                }
            } receiveValue: { [weak self] noData in
                self?.message = noData.message
            }.store(in: &cancelable)
    }
    func passwordChange(old:String,new:String){
        UserApiService.passwordChange(old: old, new: new)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.logout(tokenExpired: true)
                case .finished:
                    print(completion)
                }
            } receiveValue: { [weak self] noData in
                self?.message = noData.message
            }.store(in: &cancelable)
    }
}
