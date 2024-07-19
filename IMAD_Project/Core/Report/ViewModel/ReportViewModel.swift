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
                    print(error.localizedDescription)
                case .finished:
                    print(completion)
                }
            } receiveValue: { data in
                self.success.send(data.message)
            }.store(in: &cancelable)
    }
    func reportReview(id:Int,type:String,description:String){
        ReportApiService.user(id: id, type: type, description: description)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    print(completion)
                }
            } receiveValue: { data in
                self.success.send(data.message)
            }.store(in: &cancelable)
    }
    func reportPosting(id:Int,type:String,description:String){
        ReportApiService.user(id: id, type: type, description: description)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    print(completion)
                }
            } receiveValue: { data in
                self.success.send(data.message)
            }.store(in: &cancelable)
    }
    func reportComment(id:Int,type:String,description:String){
        ReportApiService.user(id: id, type: type, description: description)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    print(completion)
                }
            } receiveValue: { data in
                self.success.send(data.message)
            }.store(in: &cancelable)
    }
}
