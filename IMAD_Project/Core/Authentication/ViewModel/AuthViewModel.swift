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
    
    @Published var user:UserResponse? = nil
    @Published var registerRes:RegisterResponse? = nil
    
    var cancelable = Set<AnyCancellable>()
    
    func register(id:String,email:String,password:String){
        AuthApiService.register(id: id, email: email, password: password)
            .sink { completion in
                print("회원가입 완료 \(completion)")
            } receiveValue: { receivedValue in
                self.registerRes = receivedValue
            }.store(in: &cancelable)
    }
    func login(id:String,password:String){
        AuthApiService.login(id: id, password: password)
            .sink { completion in
                print("로그인 완료 \(completion)")
            } receiveValue: { receivedValue in
                self.user = receivedValue
            }.store(in: &cancelable)
    }
}
