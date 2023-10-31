//
//  CheckDataViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/28.
//

import Foundation
import Alamofire
import Combine

class CheckDataViewModel:ObservableObject{
    
    @Published var checkRes:Validation? = nil
    @Published var check:Bool? = nil
    
    var cancelable = Set<AnyCancellable>()
    var tokenExpired = PassthroughSubject<String,Never>()
    
    func checkEmail(email:String){
        CheckApiService.checkEmail(email: email)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] receivedValue in
                print(receivedValue.message)
                if receivedValue.status >= 200 && receivedValue.status <= 300{
                    self?.check = receivedValue.data?.validation
                }else if receivedValue.status == 401{
                    AuthApiService.getToken()
                    self?.tokenExpired.send(receivedValue.message)
                }
                self?.checkRes = receivedValue
            }.store(in: &cancelable)

    }
    
    func checkNickname(nickname:String){
        CheckApiService.checkNickname(nickname: nickname)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] receivedValue in
                print(receivedValue.message)
                if receivedValue.status >= 200 && receivedValue.status <= 300{
                    self?.check = receivedValue.data?.validation
                }else if receivedValue.status == 401{
                    AuthApiService.getToken()
                    self?.tokenExpired.send(receivedValue.message)
                }
                self?.checkRes = receivedValue
            }.store(in: &cancelable)

    }
}
