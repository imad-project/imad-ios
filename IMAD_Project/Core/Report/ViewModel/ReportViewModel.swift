//
//  File.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/19/24.
//

import Foundation
import Combine

class ReportViewModel:ObservableObject{
    
    var success = PassthroughSubject<String,Never>()
    var cancelable = Set<AnyCancellable>()
    
    func reportUser(id:Int,type:String,description:String){
        ReportApiService.user(id: id, type: type, description: description)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    self.success.send("이미 차단 되었거나 신고 접수된 사용자 입니다.")
                    print(error.localizedDescription)
                case .finished:
                    print(completion)
                }
            } receiveValue: { data in
                self.success.send(data.message)
            }.store(in: &cancelable)
    }
    func reportReview(id:Int,type:String,description:String){
        ReportApiService.review(id: id, type: type, description: description)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    self.success.send("신고 접수가 실패했습니다.")
                    print(error.localizedDescription)
                case .finished:
                    print(completion)
                }
            } receiveValue: { data in
                self.success.send(data.message)
            }.store(in: &cancelable)
    }
    func reportPosting(id:Int,type:String,description:String){
        ReportApiService.posting(id: id, type: type, description: description)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    self.success.send("신고 접수가 실패했습니다.")
                    print(error.localizedDescription)
                case .finished:
                    print(completion)
                }
            } receiveValue: { data in
                self.success.send(data.message)
            }.store(in: &cancelable)
    }
    func reportComment(id:Int,type:String,description:String){
        ReportApiService.comment(id: id, type: type, description: description)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    self.success.send("신고 접수가 실패했습니다.")
                    print(error.localizedDescription)
                case .finished:
                    print(completion)
                }
            } receiveValue: { data in
                self.success.send(data.message)
            }.store(in: &cancelable)
    }
}
