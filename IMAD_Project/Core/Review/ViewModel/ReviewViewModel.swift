//
//  ReviewViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/09/12.
//

import Foundation
import Combine

final class ReviewViewModel:ObservableObject{
    
    var cancelable = Set<AnyCancellable>()
    var success = PassthroughSubject<(),Never>()
    var refreschTokenExpired = PassthroughSubject<(),Never>()
    
    @Published var review:ReadReviewResponse?
    @Published var reviewList:[ReadReviewResponse] = []  //리뷰 리스트
    
    
    @Published var currentPage = 1
    @Published var maxPage = 0
    
    @Published var error = ""
    
    init(review:ReadReviewResponse?,reviewList:[ReadReviewResponse]){
        self.review = review
        self.reviewList = reviewList
    }
    
    func writeReview(contentsId:Int,title:String,content:String,score:Double,spoiler:Bool){
        ReviewApiService.reviewWrite(id: contentsId, title: title, content: content, score: score, spoiler: spoiler)
            .sink {completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.refreschTokenExpired.send()
                case .finished:
                    print(completion)
                }
            } receiveValue: { _ in
                self.success.send()
            }.store(in: &cancelable)
    }
    func readReview(id:Int){
        ReviewApiService.reviewRead(id: id)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.refreschTokenExpired.send()
                case .finished:
                    print(completion)
                }
            } receiveValue: { [weak self] review in
                self?.review = review.data
            }.store(in: &cancelable)
    }
    
    func readReviewList(id:Int,page:Int,sort:String,order:Int){
        ReviewApiService.reviewReadList(id: id, page: page, sort: sort, order: order)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.refreschTokenExpired.send()
                case .finished:
                    print(completion)
                }
                self.currentPage = page
            } receiveValue: { [weak self] review in
                if let data = review.data{
                    self?.reviewList.append(contentsOf: data.reviewDetailsResponseList)
                    self?.maxPage = data.totalPages
                }
            }.store(in: &cancelable)
    }
    func updateReview(reviewId:Int,title:String,content:String,score:Double,spoiler:Bool){
        ReviewApiService.reviewUpdate(id: reviewId, title: title, content: content, score: score, spoiler: spoiler)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.refreschTokenExpired.send()
                case .finished:
                    print(completion)
                }
            } receiveValue: { _ in
                self.success.send()
            }.store(in: &cancelable)
    }
    func deleteReview(id:Int){
        ReviewApiService.reviewDelete(id: id)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.refreschTokenExpired.send()
                case .finished:
                    print(completion)
                }
            } receiveValue: { _ in
                self.success.send()
            }.store(in: &cancelable)
    }
   
    
    func likeReview(id:Int,status:Int){
        ReviewApiService.reviewLike(id: id, status: status)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.refreschTokenExpired.send()
                case .finished:
                    print(completion)
                }
            } receiveValue: { _ in
                self.success.send()
            }.store(in: &cancelable)
    }
    func myReviewList(page:Int){
        ReviewApiService.myReview(page: page)
            .sink {  completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.refreschTokenExpired.send()
                case .finished:
                    print(completion)
                }
                self.currentPage = page
            } receiveValue: { [weak self] data in
                if let data = data.data{
                    self?.reviewList.append(contentsOf: data.reviewDetailsResponseList)
                    self?.maxPage = data.totalPages
                }
            }.store(in: &cancelable)

    }
    func myLikeReviewList(page:Int,likeStatus:Int){
        ReviewApiService.myLikeReview(page: page,likeStatus: likeStatus)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.refreschTokenExpired.send()
                case .finished:
                    print(completion)
                }
                self.currentPage = page
            } receiveValue: { [weak self] data in
                if let data = data.data{
                    self?.reviewList.append(contentsOf: data.reviewDetailsResponseList)
                    self?.maxPage = data.totalPages
                }
            }.store(in: &cancelable)

    }
    func like(review:ReadReviewResponse){
        if review.likeStatus < 1{
            if review.likeStatus < 0{
                self.review?.dislikeCnt -= 1
            }
            self.review?.likeCnt += 1
            
            self.review?.likeStatus = 1
            self.likeReview(id: review.reviewID, status: 1)
        }else{
            self.review?.likeCnt -= 1
            self.review?.likeStatus = 0
            self.likeReview(id: review.reviewID, status: 0)
        }
    }
    func disLike(review:ReadReviewResponse){
        if review.likeStatus > -1{
            if review.likeStatus > 0{
                self.review?.likeCnt -= 1
            }
            self.review?.dislikeCnt += 1
            self.review?.likeStatus = -1
            self.likeReview(id: review.reviewID, status: -1)
        }else{
            self.review?.likeStatus = 0
            self.review?.dislikeCnt -= 1
            self.likeReview(id: review.reviewID, status: 0)
        }
    }
}
