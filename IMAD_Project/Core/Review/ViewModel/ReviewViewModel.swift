//
//  ReviewViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/09/12.
//

import Foundation
import Combine

@MainActor
class ReviewViewModel:ObservableObject{
    
    var cancelable = Set<AnyCancellable>()
    var success = PassthroughSubject<(),Never>()
    
    @Published var reviewInfo:ReadReviewResponse?
    
    func writeReview(id:Int,title:String,content:String,score:Double,spoiler:Bool){
        ReviewApiService.reviewWrite(id: id, title: title, content: content, score: score, spoiler: spoiler)
            .sink { completion in
                print(completion)
            } receiveValue: { recievedValue in
                print(recievedValue.message)
                if recievedValue.status >= 200 && recievedValue.status < 300{
                    self.success.send()
                }
            }.store(in: &cancelable)
    }
    func readReview(id:Int){
        ReviewApiService.reviewRead(id: id)
            .sink { completion in
                print(completion)
            } receiveValue: { recievedValue in
                print(recievedValue.message)
                if recievedValue.status >= 200 && recievedValue.status < 300{
                    self.reviewInfo = recievedValue.data
                    self.success.send()
                }
            }.store(in: &cancelable)
    }
    func updateReview(id:Int){
        ReviewApiService.reviewUpdate(id: id)
            .sink { completion in
                print(completion)
            } receiveValue: { recievedValue in
                print(recievedValue.message)
                if recievedValue.status >= 200 && recievedValue.status < 300{
                    self.success.send()
                }
            }.store(in: &cancelable)
    }
    func deleteReview(id:Int){
        ReviewApiService.reviewDelete(id: id)
            .sink { completion in
                print(completion)
            } receiveValue: { recievedValue in
                print(recievedValue.message)
                if recievedValue.status >= 200 && recievedValue.status < 300{
                    self.success.send()
                }
            }.store(in: &cancelable)
    }
}
