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
    
    @Published var message = ""
//    @Published var checkResponse:ValidationResponse? = nil
    @Published var possible:Bool = false
    
    var cancelable = Set<AnyCancellable>()
    var tokenExpired = PassthroughSubject<String,Never>()
    
    func checkEmail(email:String){
        CheckApiService.checkEmail(email: email)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] data in
//                if receivedValue.status >= 200 && receivedValue.status <= 300{
//                    self?.check = receivedValue.data?.validation
//                }else if receivedValue.status == 401{
////                    AuthApiService.getToken()
//                    self?.tokenExpired.send(receivedValue.message)
//                }
//                self?.checkResponse = data.data
                if let chekRes = data.data?.validation{
                    self?.showMessage(message: chekRes ? "사용할 수 있는 이메일입니다!" :"사용 중인 이메일입니다!" , possible: chekRes)
                }
            }.store(in: &cancelable)

    }
    
    func checkNickname(nickname:String){
        CheckApiService.checkNickname(nickname: nickname)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] data in
//                print(receivedValue.message)
//                if receivedValue.status >= 200 && receivedValue.status <= 300{
//                    self?.check = receivedValue.data?.validation
//                }else if receivedValue.status == 401{
////                    AuthApiService.getToken()
//                    self?.tokenExpired.send(receivedValue.message)
//                }
//                self?.checkResponse = data.data
                if let chekRes = data.data?.validation{
                    self?.showMessage(message: chekRes ? "사용할 수 있는 닉네임입니다!" : "사용 중인 닉네임입니다!" , possible: chekRes)
                }
            }.store(in: &cancelable)

    }
    func showMessage(message:String,possible:Bool){
        self.possible = possible
        self.message = message
    }
}
