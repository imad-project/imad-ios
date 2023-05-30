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
    
    func checkEmail(email:String){
        CheckApiService.checkEmail(email: email)
            .sink { completion in
                if let status = self.checkRes?.status,status >= 200 && status <= 300{
                    self.check = self.checkRes?.data?.validation
                    print("이메일 중복검사 성공 :\(completion) \(self.checkRes?.message ?? "")")
                }else{
                    print("이메일 중복검사 실패 : \(completion) \(self.checkRes?.message ?? "")")
                }
            } receiveValue: { receivedValue in
                self.checkRes = receivedValue
            }.store(in: &cancelable)

    }
    
    func checkNickname(nickname:String){
        CheckApiService.checkNickname(nickname: nickname)
            .sink { completion in
                if let status = self.checkRes?.status,status >= 200 && status <= 300{
                    print("닉네임 중복검사 성공 :\(completion)")
                    self.check = self.checkRes?.data?.validation
                }else{
                    print("닉네임 중복검사 실패 : \(completion) \(self.checkRes?.message ?? "")")
                }
            } receiveValue: { receivedValue in
                self.checkRes = receivedValue
            }.store(in: &cancelable)

    }
}
