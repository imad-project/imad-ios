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

    var cancelable = Set<AnyCancellable>()
    var checkResultEvent = PassthroughSubject<(possible:Bool,message:String),Never>()
    
    func checkEmail(email:String){
        CheckApiService.checkEmail(email: email)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] data in
                guard let chekResult = data.data?.validation else { return }
                self?.checkResultEvent.send((chekResult,chekResult ? "사용할 수 있는 이메일입니다!":"사용 중인 이메일입니다!"))
            }.store(in: &cancelable)
    }
    func checkNickname(nickname:String){
        CheckApiService.checkNickname(nickname: nickname)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] data in
                guard let chekResult = data.data?.validation else { return }
                self?.checkResultEvent.send((chekResult,chekResult ? "사용할 수 있는 닉네임입니다!":"사용 중인 닉네임입니다!"))
            }.store(in: &cancelable)
    }
}
