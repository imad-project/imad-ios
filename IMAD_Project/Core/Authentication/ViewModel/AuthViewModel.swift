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
    
    @Published var loginRes:UserInfoResponse? = nil
    @Published var registerRes:RegisterResponse? = nil
    
    var registerSuccess = PassthroughSubject<Bool,Never>()
    
    var cancelable = Set<AnyCancellable>()
    
    func register(email:String,nickname:String,password:String,authProvider:String){
        AuthApiService.register(email: email, nickname: nickname, password: password,authProvider:authProvider)
            .sink { completion in
                switch completion{
                case .finished:
                    print("회원가입 완료 \(completion)")
                    if let code = self.registerRes?.code,code != "BAD_REQUEST"{
                        self.registerSuccess.send(true)
                    }else{
                        self.registerSuccess.send(false)
                    }
                case .failure(let error):
                    print("회원가입 실패 \(error.localizedDescription)")
                }
            } receiveValue: { receivedValue in
                self.registerRes = receivedValue
            }.store(in: &cancelable)
    }
    func login(email:String,password:String){
        AuthApiService.login(email: email, password: password)
            .sink { completion in
                print("로그인 완료 \(completion)")
            } receiveValue: { receivedValue in
                self.loginRes = receivedValue
            }.store(in: &cancelable)
    }
    func oauth(registrationId:String){
        AuthApiService.oauth(registrationId: registrationId)
            .sink { completion in
                print("로그인 완료 \(completion)")
            } receiveValue: { receivedValue in
               
            }.store(in: &cancelable)
    }
}
