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
    var reviewWriteError = PassthroughSubject<(),Never>()
    var tokenExpired = PassthroughSubject<String,Never>()
    
    @Published var reviewInfo:ReadReviewResponse?
    @Published var reviewList:[ReadReviewResponse] = []  //리뷰 리스트
    @Published var reviewDetailsInfo:ReadReviewListResponse?
    
    @Published var myReview:[ReadReviewResponse] = []
    @Published var myLikeReview:[ReadReviewResponse] = []
    
    @Published var myReviewCnt = 0
    @Published var myLikeReviewCnt = 0
    
    @Published var page = 1
    
    @Published var error = ""
    
    init(reviewList:[ReadReviewResponse]){
        self.reviewList = reviewList
    }
    
    func writeReview(id:Int,title:String,content:String,score:Double,spoiler:Bool){
        ReviewApiService.reviewWrite(id: id, title: title, content: content, score: score, spoiler: spoiler)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] recievedValue in
                print(recievedValue.message)
                if recievedValue.status >= 200 && recievedValue.status < 300{
                    self?.success.send()
                }
                else if recievedValue.status == 409{
                    self?.error = recievedValue.message
                    self?.reviewWriteError.send()
                }
                else if recievedValue.status == 401{
//                    AuthApiService.getToken()
                    self?.tokenExpired.send(recievedValue.message)
                }
            }.store(in: &cancelable)
    }
    func readReview(id:Int){
        ReviewApiService.reviewRead(id: id)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] recievedValue in
                print(recievedValue.message)
                if recievedValue.status >= 200 && recievedValue.status < 300{
                    self?.reviewInfo = recievedValue.data
                    self?.success.send()
                }
                else if recievedValue.status == 401{
//                    AuthApiService.getToken()
                    self?.tokenExpired.send(recievedValue.message)
                }
            }.store(in: &cancelable)
    }
    func updateReview(id:Int,title:String,content:String,score:Double,spoiler:Bool){
        ReviewApiService.reviewUpdate(id: id, title: title, content: content, score: score, spoiler: spoiler)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] recievedValue in
                print(recievedValue.message)
                if recievedValue.status >= 200 && recievedValue.status < 300{
                    self?.success.send()
                }
                else if recievedValue.status == 401{
//                    AuthApiService.getToken()
                    self?.tokenExpired.send(recievedValue.message)
                }
            }.store(in: &cancelable)
    }
    func deleteReview(id:Int){
        ReviewApiService.reviewDelete(id: id)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] recievedValue in
                print(recievedValue.message)
                if recievedValue.status >= 200 && recievedValue.status < 300{
                    self?.success.send()
                }
                else if recievedValue.status == 401{
//                    AuthApiService.getToken()
                    self?.tokenExpired.send(recievedValue.message)
                }
            }.store(in: &cancelable)
    }
    func readReviewList(id:Int,page:Int,sort:String,order:Int){
        ReviewApiService.reviewReadList(id: id, page: page, sort: sort, order: order)
            .sink { completion in
                print(completion)
                self.success.send()
            } receiveValue: { [weak self] recievedValue in
                print(recievedValue.message)
                if recievedValue.status >= 200 && recievedValue.status < 300{
                    if let list = recievedValue.data?.reviewDetailsResponseList{
                        self?.reviewDetailsInfo = recievedValue.data
                        self?.reviewList = list
                    }
                }
                else if recievedValue.status == 401{
//                    AuthApiService.getToken()
                    self?.tokenExpired.send(recievedValue.message)
                }
            }.store(in: &cancelable)
    }
    
    func likeReview(id:Int,status:Int){
        ReviewApiService.reviewLike(id: id, status: status)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] recievedValue in
                if recievedValue.status >= 200 && recievedValue.status < 300{
                    self?.readReview(id: id)
                }
                else if recievedValue.status == 401{
//                    AuthApiService.getToken()
                    self?.tokenExpired.send(recievedValue.message)
                }
            }.store(in: &cancelable)
    }
    func myReviewList(page:Int){
        ReviewApiService.myReview(page: page)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] recievedValue in
                if recievedValue.status >= 200 && recievedValue.status < 300{
                    guard let data = recievedValue.data else {return}
                    self?.myReviewCnt = data.totalElements ?? 0
                    self?.myReview.append(contentsOf: data.reviewDetailsResponseList)
                }
                else if recievedValue.status == 401{
//                    AuthApiService.getToken()
                    self?.tokenExpired.send(recievedValue.message)
                }
            }.store(in: &cancelable)

    }
    func myLikeReviewList(page:Int){
        ReviewApiService.myLikeReview(page: page)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] recievedValue in
                if recievedValue.status >= 200 && recievedValue.status < 300{
                    guard let data = recievedValue.data else {return}
                    self?.myLikeReviewCnt = data.totalElements ?? 0
//                    if let list = data.reviewDetailsResponseList{
                    self?.myLikeReview.append(contentsOf: data.reviewDetailsResponseList)
//                    }
                }
                else if recievedValue.status == 401{
//                    AuthApiService.getToken()
                    self?.tokenExpired.send(recievedValue.message)
                }
            }.store(in: &cancelable)

    }
}
