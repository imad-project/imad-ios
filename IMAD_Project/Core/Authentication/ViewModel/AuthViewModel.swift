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
    
    
//    @Published var registerRes:RegisterResponse? = nil
//    @Published var getUserRes:GetUserInfo? = nil
//    @Published var passwordChangeRes:GetUserInfo? = nil
//    @Published var selection:RegisterFilter = .nickname     //탭뷰
//
//    @Published var getToken = 0
//
//    @Published var guestMode = false
//    @Published var loginMode = false
//
//    @Published var profileInfo:LoginResponse = LoginResponse(email: "", nickname: "", gender: "", ageRange: 20, profileImage: -1, tvGenre: [], movieGenre: [], authProvider: "", role: "")
    
    @Published var message = ""
    @Published var user:UserInfo? = nil
    var success = PassthroughSubject<(),Never>()
    
//    var registerSuccess = PassthroughSubject<Bool,Never>()
//
//
//    var loginSuccess = PassthroughSubject<Bool,Never>()
//    var getUserSuccess = PassthroughSubject<Bool,Never>()
//    var patchInfoSuccess = PassthroughSubject<Bool,Never>()
//    var deleteSuccess = PassthroughSubject<Bool,Never>()
//    var passwordChangeSuccess = PassthroughSubject<(),Never>()
    var cancelable = Set<AnyCancellable>()
//    var tokenExpired = PassthroughSubject<String,Never>()
//    var postingSuccess = PassthroughSubject<Int,Never>()
    
    
    func register(email:String,password:String,authProvider:String){
        AuthApiService.register(email: email, password: password,authProvider:authProvider)
            .sink(receiveCompletion: { _ in
                self.success.send()
            }, receiveValue: { [weak self] noData in
                self?.message = noData.message
            }).store(in: &cancelable)


//            .sink { completion in
//                if let code = self.registerRes?.statusCode,code >= 200 && code <= 300{
//                    self.registerSuccess.send(true)
//                    self.guestMode = true
//                }else{
//                    self.registerSuccess.send(false)
//                }
//            } receiveValue: { [weak self] receivedValue in
//                self?.registerRes = receivedValue
//            }.store(in: &cancelable)
    }
    func login(email:String,password:String){
        AuthApiService.login(email: email, password: password)
            .sink { _ in
                self.success.send()
            } receiveValue: { [weak self] user in
                self?.user = user
            }.store(in: &cancelable)

//                if let code = self.getUserRes?.status,code >= 200 && code <= 300{
//                    if self.getUserRes?.data?.role == "GUEST"{
//                        self.guestMode = true
//                    }
//                    self.loginSuccess.send(true)
//                    print("로그인 완료 \(completion)")
//                }else{
//                    self.loginSuccess.send(false)
//                    print("로그인 실패 \(completion)")
//                }
//            } receiveValue: { [weak self] receivedValue in
//                self?.getUserRes = receivedValue
//                guard let data = receivedValue.data else {return}
//                self?.profileInfo = data
//            }.store(in: &cancelable)
    }
    

    func getUser(){
        UserApiService.user()
            .sink { _ in
                self.success.send()
            } receiveValue: { [weak self] user in
                self?.user = user
            }.store(in: &cancelable)

//            .sink { completion in
//                print(completion)
//            } receiveValue: { [weak self] receivedValue in
//                self?.loginMode = true
//                if receivedValue.data?.role == "GUEST"{
//                    self?.guestMode = true
//                }
//                switch receivedValue.status{
//
////                case 200...300:
////                    print(receivedValue.message)
////                    self?.getUserRes = receivedValue
////                    guard let data = receivedValue.data else {return}
////                    self?.profileInfo = data
//
////                    self?.getToken = 0
////                case 401:
////                    AuthApiService.getToken()
//                default:
////                    print(receivedValue.status)
//                    break
//                }
//            }.store(in: &cancelable)
    }
    func patchUser(gender:String?,ageRange:Int?,image:Int,nickname:String,tvGenre:[Int]?,movieGenre:[Int]?){
        UserApiService.patchUser(gender: gender, ageRange: ageRange, image: image, nickname: nickname, tvGenre: tvGenre,movieGenre:movieGenre)
            .sink { _ in
                self.success.send()
            } receiveValue: { [weak self] user in
                self?.user = user
            }.store(in: &cancelable)

//            .sink { completion in
//                self.patchInfoSuccess.send(true)
//                print(completion)
//            } receiveValue: { [weak self] receivedValue in
//                switch receivedValue.status{
//                case 200...300:
//                    self?.getUserRes = receivedValue
//                    guard let data = receivedValue.data else {return}
//                    self?.profileInfo = data
//                case 401:
////                    AuthApiService.getToken()
//                    self?.tokenExpired.send(receivedValue.message)
//                default: break
//                }
//
//            }.store(in: &cancelable)
    }
    func logout(){
        print("로그아웃 및 토큰 삭제")
//        loginMode = false
        user = nil
        UserDefaultManager.shared.clearAll()
    }
    func delete(authProvier:String){
        AuthApiService.delete(authProvier:authProvier)
            .sink { _ in
                self.success.send()
            } receiveValue: { [weak self] noData in
                self?.message = noData.message
            }.store(in: &cancelable)

//            .sink { completion in
//                print(completion)
//            } receiveValue: { [weak self] receivedValue in
//                switch receivedValue.status{
//                case 200...300:
//                    self?.getUserRes = receivedValue
//                    self?.deleteSuccess.send(true)
//                    self?.loginMode = false
//                    UserDefaultManager.shared.clearAll()
//                case 401:
////                    AuthApiService.getToken()
//                    self?.tokenExpired.send(receivedValue.message)
//                default: break
//                }
//            }.store(in: &cancelable)
        
    }
    func passwordChange(old:String,new:String){
        UserApiService.passwordChange(old: old, new: new)
            .sink { _ in
                self.success.send()
            } receiveValue: { [weak self] noData in
                self?.message = noData.message
            }.store(in: &cancelable)

//            .sink { completion in
//                print(completion)
//            } receiveValue: { [weak self] receivedValue in
//                switch receivedValue.status{
//                case 200...300:
//                    self?.passwordChangeRes = receivedValue
//                    self?.passwordChangeSuccess.send()
//                case 401:
////                    AuthApiService.getToken()
//                    self?.tokenExpired.send(receivedValue.message)
//                default: break
//                }
//            }.store(in: &cancelable)

    }
}
