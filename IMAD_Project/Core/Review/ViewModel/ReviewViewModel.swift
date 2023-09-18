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
    @Published var reviewList:[ReviewDetailsResponseList] = []  //리뷰 리스트
    @Published var reviewDetailsInfo:ReviewDetails?
    

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
    func readReviewList(id:Int,page:Int,sort:String,order:Int){
        ReviewApiService.reviewReadList(id: id, page: page, sort: sort, order: order)
            .sink { completion in
                print(completion)
                self.success.send()
            } receiveValue: { recievedValue in
                print(recievedValue.message)
                if recievedValue.status >= 200 && recievedValue.status < 300{
                    if let list = recievedValue.data?.reviewDetailsResponseList{
                        self.reviewDetailsInfo = recievedValue.data
                        self.reviewList = list
                    }
                }
            }.store(in: &cancelable)
    }
    
    func likeReview(id:Int,status:Int){
        ReviewApiService.reviewLike(id: id, status: status)
            .sink { completion in
                print(completion)
            } receiveValue: { recievedValue in
                if recievedValue.status >= 200 && recievedValue.status < 300{
                    self.readReview(id: id)
                }
            }.store(in: &cancelable)
    }
    func likeDislike(like:Int) -> (Int,Int){
        switch like{
        case -1:
            return (0,1)
        case 1:
            return (1,0)
        default:
            return (0,0)
        }
    }
}
